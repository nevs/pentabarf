/************************************************

  postgres.c -

  Author: matz 
  created at: Tue May 13 20:07:35 JST 1997

  Author: ematsu
  modified at: Wed Jan 20 16:41:51 1999

  $Author: noboru $
  $Date: 2003/01/06 01:38:20 $
************************************************/

#include "ruby.h"
#include "rubyio.h"
#include "st.h"

#include <libpq-fe.h>
#include <libpq/libpq-fs.h>              /* large-object interface */
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>

#ifndef HAVE_PG_ENCODING_TO_CHAR
#define pg_encoding_to_char(x) "SQL_ASCII"
#endif

#ifndef HAVE_PQFREEMEM
#define PQfreemem(ptr) free(ptr)
#endif

#ifndef StringValuePtr
#define StringValuePtr(x) STR2CSTR(x)
#endif

#define AssignCheckedStringValue(cstring, rstring) do { \
    if (!NIL_P(temp = rstring)) { \
        Check_Type(temp, T_STRING); \
        cstring = StringValuePtr(temp); \
    } \
} while (0)

#if RUBY_VERSION_CODE < 180
#define rb_check_string_type(x) rb_check_convert_type(x, T_STRING, "String", "to_str")
#endif

#define rb_check_hash_type(x) rb_check_convert_type(x, T_HASH, "Hash", "to_hash")

#define Data_Set_Struct(obj,ptr) do { \
    Check_Type(obj, T_DATA); \
    DATA_PTR(obj) = ptr; \
} while (0)


EXTERN VALUE rb_mEnumerable;

static VALUE rb_cPGconn;
static VALUE rb_cPGresult;
static VALUE rb_ePGError;
static VALUE rb_cPGlarge; 
static VALUE rb_cPGrow;

static VALUE pgresult_result_with_clear _((VALUE));
static VALUE pgresult_new _((PGresult*));

/* Large Object support */
typedef struct pglarge_object
{
    PGconn *pgconn;
    Oid lo_oid;
    int lo_fd;
} PGlarge;

static VALUE pglarge_new _((PGconn*, Oid, int));
/* Large Object support */

static void free_pgconn(PGconn *);

/*
 * See #new.
 */
static VALUE
pgconn_alloc(klass)
    VALUE klass;
{
    return Data_Wrap_Struct(klass, 0, free_pgconn, NULL);
}

static VALUE
quote_string(string)
    VALUE string;
{
    char *to;
    int len;
    VALUE result;

    to = ALLOCA_N(char, RSTRING(string)->len * 2 + 2);
    
    *to = '\'';
    len = PQescapeString(to + 1, RSTRING(string)->ptr, RSTRING(string)->len);
    *(to + len + 1) = '\'';
    
    result = rb_str_new(to, len + 2);
    OBJ_INFECT(result, string);
    
    return result;
}

static int
build_key_value_i(key, value, result)
    VALUE key, value, result;
{
    VALUE key_value;
    if (key == Qundef) return ST_CONTINUE;
    key_value = rb_str_dup(key);
    rb_str_cat(key_value, "=", 1);
    rb_str_concat(key_value, quote_string(value));
    rb_ary_push(result, key_value);
    return ST_CONTINUE;
}

static PGconn *
try_connectdb(arg)
    VALUE arg;
{
    VALUE conninfo;

    if (!NIL_P(conninfo = rb_check_string_type(arg))) {
        // do nothing
    }
    else if (!NIL_P(conninfo = rb_check_hash_type(arg))) {
        VALUE key_values = rb_ary_new2(RHASH(conninfo)->tbl->num_entries);
        rb_hash_foreach(conninfo, build_key_value_i, key_values);
        conninfo = rb_ary_join(key_values, rb_str_new2(" "));
    }
    else {
        return NULL;
    }

    return PQconnectdb(StringValuePtr(conninfo));
}

static PGconn *
try_setdbLogin(args)
    VALUE args;
{
    VALUE temp;
    char *host, *port, *opt, *tty, *dbname, *login, *pwd;
    host=port=opt=tty=dbname=login=pwd=NULL;

    rb_funcall(args, rb_intern("flatten!"), 0);

    AssignCheckedStringValue(host, rb_ary_entry(args, 0));
    if (!NIL_P(temp = rb_ary_entry(args, 1)) && NUM2INT(temp) != -1) {
        temp = rb_funcall(temp, rb_intern("to_s"), 0);
        port = StringValuePtr(temp);
    }
    AssignCheckedStringValue(opt, rb_ary_entry(args, 2));
    AssignCheckedStringValue(tty, rb_ary_entry(args, 3));
    AssignCheckedStringValue(dbname, rb_ary_entry(args, 4));
    AssignCheckedStringValue(login, rb_ary_entry(args, 5));
    AssignCheckedStringValue(pwd, rb_ary_entry(args, 6));

    return PQsetdbLogin(host, port, opt, tty, dbname, login, pwd);
}

static VALUE
pgconn_connect(argc, argv, self)
    int argc;
    VALUE *argv;
    VALUE self;
{
    VALUE args;
    PGconn *conn = NULL;

    rb_scan_args(argc, argv, "0*", &args); 
    if (RARRAY(args)->len == 1) { 
        conn = try_connectdb(rb_ary_entry(args, 0));
    }
    if (conn == NULL) {
        conn = try_setdbLogin(args);
    }

    if (PQstatus(conn) == CONNECTION_BAD) {
        rb_raise(rb_ePGError, PQerrorMessage(conn));
    }

    Data_Set_Struct(self, conn);
    return self;
}

static VALUE
pgconn_s_connect(argc, argv, klass)
    int argc;
    VALUE *argv;
    VALUE klass;
{
    return rb_class_new_instance(argc, argv, klass);
}

/*
 * call-seq:
 *    PGconn.escape( str )
 *
 * Returns a SQL-safe version of the String _str_. Unlike #quote, does not wrap the String in '...'.
 */
static VALUE
pgconn_s_escape(self, obj)
    VALUE self;
    VALUE obj;
{
    char *to;
    long len;
    VALUE ret;
    
    Check_Type(obj, T_STRING);
    
    to = ALLOCA_N(char, RSTRING(obj)->len * 2);
    
    len = PQescapeString(to, RSTRING(obj)->ptr, RSTRING(obj)->len);
    
    ret = rb_str_new(to, len);
    OBJ_INFECT(ret, obj);
    
    return ret;
}

/*
 * call-seq:
 *    PGConn.quote( obj )
 *    PGConn.quote( obj ){ |obj| ... }
 * 
 * If _obj_ is a Number, String, Array, +nil+, +true+, or +false+ then
 * #quote returns a String representation of that object safe for use in PostgreSQL.
 * 
 * If _obj_ is not one of the above classes and a block is supplied to #quote,
 * the block is invoked, passing along the object. The return value from the
 * block is returned as a string.
 *
 * If _obj_ is not one of the recognized classes andno block is supplied,
 * a PGError is raised.
 */
static VALUE
pgconn_s_quote(self, obj)
    VALUE self;
    VALUE obj;
{
    VALUE ret;
    char *to;
    long len;
    long idx;
    
    switch(TYPE(obj)) {
    case T_STRING:
      ret = quote_string(obj);
      break;
      
    case T_FIXNUM:
    case T_BIGNUM:
    case T_FLOAT:
      ret = rb_obj_as_string(obj);
      break;
      
    case T_NIL:
      ret = rb_str_new2("NULL");
      break;
      
    case T_TRUE:
      ret = rb_str_new2("'t'");
      break;
      
    case T_FALSE:
      ret = rb_str_new2("'f'");
      break;
      
    case T_ARRAY:
      ret = rb_str_new(0,0);
      len = RARRAY(obj)->len;
      for(idx=0; idx<len; idx++) {
          rb_str_concat(ret,  pgconn_s_quote(self, rb_ary_entry(obj, idx)));
          if (idx<len-1) {
              rb_str_cat2(ret, ", ");
          }
      }
      break;
    default:
      if (rb_block_given_p()==Qtrue) {
          ret = rb_yield(obj);
      } else {
          rb_raise(rb_ePGError, "can't quote");
      }
    }
    
    return ret;
}

/*
 * call-seq:
 *   PGConn.escape_bytea( obj )
 *
 * Escapes binary data for use within an SQL command with the type +bytea+.
 * 
 * Certain byte values must be escaped (but all byte values may be escaped)
 * when used as part of a +bytea+ literal in an SQL statement. In general, to
 * escape a byte, it is converted into the three digit octal number equal to
 * the octet value, and preceded by two backslashes. The single quote (') and
 * backslash (\) characters have special alternative escape sequences.
 * #escape_bytea performs this operation, escaping only the minimally required bytes.
 * 
 * See the PostgreSQL 7.4 Documentation on PQescapeBytea[http://www.postgresql.org/docs/7.4/static/libpq-exec.html#LIBPQ-EXEC-ESCAPE-BYTEA] for more information.
 */
static VALUE
pgconn_s_escape_bytea(self, obj)
    VALUE self;
    VALUE obj;
{
    unsigned char c;
    char *from, *to;
    long idx;
    size_t from_len, to_len;
    VALUE ret;
    
    Check_Type(obj, T_STRING);
    from      = RSTRING(obj)->ptr;
    from_len  = RSTRING(obj)->len;
    
    to = (char *)PQescapeBytea(from, from_len, &to_len);
    
    ret = rb_str_new(to, to_len - 1);
    OBJ_INFECT(ret, obj);
    
    PQfreemem(to);
    
    return ret;
}

static VALUE
pgconn_s_unescape_bytea(self, obj)
    VALUE self;
    VALUE obj;
{
    char *from, *to;
    size_t to_len;
    VALUE ret;
    
    Check_Type(obj, T_STRING);
    from = StringValuePtr(obj);
    
    to = (char *)PQunescapeBytea(from, &to_len);
    
    ret = rb_str_new(to, to_len);
    OBJ_INFECT(ret, obj);
    
    PQfreemem(to);
    
    return ret;
}

/*
 * call-seq:
 *     PGconn.connect(    pghost,  pgport, pgoptions, pgtty, dbname, login, passwd )  =>  conn
 *     PGconn.new(        pghost,  pgport, pgoptions, pgtty, dbname, login, passwd )  =>  conn
 *     PGconn.setdb(      pghost,  pgport, pgoptions, pgtty, dbname, login, passwd )  =>  conn
 *     PGconn.setdblogin( pghost,  pgport, pgoptions, pgtty, dbname, login, passwd )  =>  conn
 *  
 *  _pghost_::     server hostname (String)
 *  _pgport_::     server port number (Integer)
 *  _pgoptions_::  backend options (String)
 *  _pgtty_::      tty to print backend debug message <i>(ignored in newer versions of PostgreSQL)</i> (String)
 *  _dbname_::     connecting database name (String)
 *  _login_::      login user name (String)
 *  _passwd_::     login password (String)
 *  
 *  On failure, it raises a PGError exception.
 */
#ifndef HAVE_RB_DEFINE_ALLOC_FUNC
static VALUE
pgconn_s_new(argc, argv, klass)
    int argc;
    VALUE *argv;
    VALUE klass;
{
    VALUE obj = rb_obj_alloc(klass);
    rb_obj_call_init(obj, argc, argv);
    return obj;
}
#endif

/*
 * See #new.
 */
static VALUE
pgconn_init(argc, argv, self)
    int argc;
    VALUE *argv;
    VALUE self;
{
    return pgconn_connect(argc, argv, self);
}

static PGconn*
get_pgconn(obj)
    VALUE obj;
{
    PGconn *conn;

    Data_Get_Struct(obj, PGconn, conn);
    if (conn == 0) rb_raise(rb_ePGError, "closed connection");
    return conn;
}

/*
 * call-seq:
 *    conn.close()
 *
 * Closes the backend connection.
 */
static VALUE
pgconn_close(obj)
    VALUE obj;
{
    PQfinish(get_pgconn(obj));
    DATA_PTR(obj) = 0;
    
    return Qnil;
}

/*
 * call-seq:
 *    conn.reset()
 *
 * Resets the backend connection. This method closes the backend  connection and tries to re-connect.
 */
static VALUE
pgconn_reset(obj)
    VALUE obj;
{
    PQreset(get_pgconn(obj));
    return obj;
}

static PGresult*
get_pgresult(obj)
    VALUE obj;
{
    PGresult *result;

    Data_Get_Struct(obj, PGresult, result);
    if (result == 0) rb_raise(rb_ePGError, "query not performed");
    return result;
}

/*
 * call-seq:
 *    conn.exec( sql )
 *
 * Sends SQL query request specified by _sql_ to the PostgreSQL.
 * Returns a PGresult instance on success.
 * On failure, it raises a PGError exception.
 */
static VALUE
pgconn_exec(obj, str)
    VALUE obj, str;
{
    PGconn *conn = get_pgconn(obj);
    PGresult *result;
    int status;
    char *msg;

    Check_Type(str, T_STRING);

    result = PQexec(conn, StringValuePtr(str));
    if (!result) {
        rb_raise(rb_ePGError, PQerrorMessage(conn));
    }
    status = PQresultStatus(result);

    switch (status) {
    case PGRES_TUPLES_OK:
    case PGRES_COPY_OUT:
    case PGRES_COPY_IN:
    case PGRES_EMPTY_QUERY:
    case PGRES_COMMAND_OK:      /* no data will be received */
      return pgresult_new(result);

    case PGRES_BAD_RESPONSE:
    case PGRES_FATAL_ERROR:
    case PGRES_NONFATAL_ERROR:
      msg = PQerrorMessage(conn);
      break;
    default:
      msg = "internal error : unknown result status.";
      break;
    }
    PQclear(result);
    rb_raise(rb_ePGError, msg);
}

/*
 * call-seq:
 *    conn.async_exec( sql )
 *
 * Sends an asyncrhonous SQL query request specified by _sql_ to the PostgreSQL.
 * Returns a PGresult instance on success.
 * On failure, it raises a PGError exception.
 */
static VALUE
pgconn_async_exec(obj, str)
    VALUE obj, str;
{
    PGconn *conn = get_pgconn(obj);
    PGresult *result;
    int status;
    char *msg;

    int cs;
    int ret;
    fd_set rset;

    Check_Type(str, T_STRING);
        
    while(result = PQgetResult(conn)) {
        PQclear(result);
    }

    if (!PQsendQuery(conn, RSTRING(str)->ptr)) {
        rb_raise(rb_ePGError, PQerrorMessage(conn));
    }

    cs = PQsocket(conn);
    for(;;) {
        FD_ZERO(&rset);
        FD_SET(cs, &rset);
        ret = rb_thread_select(cs + 1, &rset, NULL, NULL, NULL);
        if (ret < 0) {
            rb_sys_fail(0);
        }
                
        if (ret == 0) {
            continue;
        }

        if (PQconsumeInput(conn) == 0) {
            rb_raise(rb_ePGError, PQerrorMessage(conn));
        }

        if (PQisBusy(conn) == 0) {
            break;
        }
    }

    result = PQgetResult(conn);

    if (!result) {
        rb_raise(rb_ePGError, PQerrorMessage(conn));
    }
    status = PQresultStatus(result);

    switch (status) {
    case PGRES_TUPLES_OK:
    case PGRES_COPY_OUT:
    case PGRES_COPY_IN:
    case PGRES_EMPTY_QUERY:
    case PGRES_COMMAND_OK:      /* no data will be received */
      return pgresult_new(result);

    case PGRES_BAD_RESPONSE:
    case PGRES_FATAL_ERROR:
    case PGRES_NONFATAL_ERROR:
      msg = PQerrorMessage(conn);
      break;
    default:
      msg = "internal error : unknown result status.";
      break;
    }
    PQclear(result);
    rb_raise(rb_ePGError, msg);
}

/*
 * call-seq:
 *    conn.query( sql )
 *
 * Sends SQL query request specified by _sql_ to the PostgreSQL.
 * Returns an Array as the resulting tuple on success.
 * On failure, it returns +nil+, and the error details can be obtained by #error.
 */
static VALUE
pgconn_query(obj, str)
    VALUE obj, str;
{
    return pgresult_result_with_clear(pgconn_exec(obj, str));
}

/*
 * call-seq:
 *    conn.async_query( sql )
 *
 * Sends an asynchronous SQL query request specified by _sql_ to the PostgreSQL.
 * Returns an Array as the resulting tuple on success.
 * On failure, it returns +nil+, and the error details can be obtained by #error.
 */
static VALUE
pgconn_async_query(obj, str)
    VALUE obj, str;
{
    return pgresult_result_with_clear(pgconn_async_exec(obj, str));
}

/*
 * call-seq:
 *    conn.get_notify()
 *
 * Returns an array of the unprocessed notifiers.
 * If there is no unprocessed notifier, it returns +nil+.
 */
static VALUE
pgconn_get_notify(obj)
    VALUE obj;
{
    PGnotify *notify;
    VALUE ary;

    /* gets notify and builds result */
    notify = PQnotifies(get_pgconn(obj));
    if (notify == NULL) {
        /* there are no unhandled notifications */
        return Qnil;
    }
    ary = rb_ary_new3(2, rb_tainted_str_new2(notify->relname),
                      INT2NUM(notify->be_pid));
    PQfreemem(notify);

    /* returns result */
    return ary;
}

static VALUE pg_escape_regex;
static VALUE pg_escape_str;
static ID    pg_gsub_bang_id;

static void
free_pgconn(ptr)
    PGconn *ptr;
{
    PQfinish(ptr);
}

/*
 * call-seq:
 *    conn.insert_table( table, values )
 *
 * Inserts contents of the _values_ Array into the _table_.
 */
static VALUE
pgconn_insert_table(obj, table, values)
    VALUE obj, table, values;
{
    PGconn *conn = get_pgconn(obj);
    PGresult *result;
    VALUE s, buffer;
    int i, j;
    int res = 0;

    Check_Type(table, T_STRING);
    Check_Type(values, T_ARRAY);
    i = RARRAY(values)->len;
    while (i--) {
        if (TYPE(RARRAY(RARRAY(values)->ptr[i])) != T_ARRAY) {
            rb_raise(rb_ePGError, "second arg must contain some kind of arrays.");
        }
    }
    
    buffer = rb_str_new(0, RSTRING(table)->len + 17 + 1);
    /* starts query */
    snprintf(RSTRING(buffer)->ptr, RSTRING(buffer)->len, "copy %s from stdin ", StringValuePtr(table));
    
    result = PQexec(conn, StringValuePtr(buffer));
    if (!result){
        rb_raise(rb_ePGError, PQerrorMessage(conn));
    }
    PQclear(result);

    for (i = 0; i < RARRAY(values)->len; i++) {
        struct RArray *row = RARRAY(RARRAY(values)->ptr[i]);
        buffer = rb_tainted_str_new(0,0);
        for (j = 0; j < row->len; j++) {
            if (j > 0) rb_str_cat(buffer, "\t", 1);
            if (NIL_P(row->ptr[j])) {
                rb_str_cat(buffer, "\\N",2);
            } else {
                s = rb_obj_as_string(row->ptr[j]);
                rb_funcall(s,pg_gsub_bang_id,2,pg_escape_regex,pg_escape_str);
                rb_str_cat(buffer, StringValuePtr(s), RSTRING(s)->len);
            }
        }
        rb_str_cat(buffer, "\n\0", 2);
        /* sends data */
        PQputline(conn, StringValuePtr(buffer));
    }
    PQputline(conn, "\\.\n");
    res = PQendcopy(conn);

    return obj;
}

/*
 * call-seq:
 *    conn.putline()
 *
 * Sends the string to the backend server.
 * Users must send a single "." to denote the end of data transmission.
 */
static VALUE
pgconn_putline(obj, str)
    VALUE obj, str;
{
    Check_Type(str, T_STRING);
    PQputline(get_pgconn(obj), StringValuePtr(str));
    return obj;
}

/*
 * call-seq:
 *    conn.getline()
 *
 * Reads a line from the backend server into internal buffer.
 * Returns +nil+ for EOF, +0+ for success, +1+ for buffer overflowed.
 * You need to ensure single "." from backend to confirm  transmission completion.
 * The sample program <tt>psql.rb</tt> (see source for postgres) treats this copy protocol right.
 */
static VALUE
pgconn_getline(obj)
    VALUE obj;
{
    PGconn *conn = get_pgconn(obj);
    VALUE str;
    long size = BUFSIZ;
    long bytes = 0;
    int  ret;
    
    str = rb_tainted_str_new(0, size);

    for (;;) {
        ret = PQgetline(conn, RSTRING(str)->ptr + bytes, size - bytes);
        switch (ret) {
        case EOF:
          return Qnil;
        case 0:
          return str;
        case 1:
          break;
        }
        bytes += BUFSIZ;
        size += BUFSIZ;
        rb_str_resize(str, size);
    }
    return Qnil;
}

/*
 * call-seq:
 *    conn.endcopy()
 *
 * Waits until the backend completes the copying.
 * You should call this method after #putline or #getline.
 * Returns +nil+ on success; raises an exception otherwise.
 */
static VALUE
pgconn_endcopy(obj)
    VALUE obj;
{
    if (PQendcopy(get_pgconn(obj)) == 1) {
        rb_raise(rb_ePGError, "cannot complete copying");
    }
    return Qnil;
}

/*
 * call-seq:
 *    conn.notifies()
 *
 * MISSING: documentation
 */
static VALUE
pgconn_notifies(obj)
    VALUE obj;
{
    PGnotify *notifies = PQnotifies(get_pgconn(obj));
    PQfreemem(notifies);
    return Qnil;
}

static void
notice_proxy(self, message)
    VALUE self;
    const char *message;
{
    VALUE block;
    if ((block = rb_iv_get(self, "@on_notice")) != Qnil) {
        rb_funcall(block, rb_intern("call"), 1, rb_str_new2(message));
    }
}

static VALUE
pgconn_on_notice(self)
    VALUE self;
{
    VALUE block = rb_block_proc();
    PGconn *conn = get_pgconn(self);
    if (PQsetNoticeProcessor(conn, NULL, NULL) != notice_proxy) {
        PQsetNoticeProcessor(conn, notice_proxy, (void *) self);
    }
    rb_iv_set(self, "@on_notice", block);
    return self;
}

/*
 * call-seq:
 *    conn.host()
 *
 * Returns the connected server name.
 */
static VALUE
pgconn_host(obj)
    VALUE obj;
{
    char *host = PQhost(get_pgconn(obj));
    if (!host) return Qnil;
    return rb_tainted_str_new2(host);
}

/*
 * call-seq:
 *    conn.port()
 *
 * Returns the connected server port number.
 */
static VALUE
pgconn_port(obj)
    VALUE obj;
{
    char* port = PQport(get_pgconn(obj));
    return INT2NUM(atol(port));
}

/*
 * call-seq:
 *    conn.db()
 *
 * Returns the connected database name.
 */
static VALUE
pgconn_db(obj)
    VALUE obj;
{
    char *db = PQdb(get_pgconn(obj));
    if (!db) return Qnil;
    return rb_tainted_str_new2(db);
}

/*
 * call-seq:
 *    conn.options()
 *
 * Returns backend option string.
 */
static VALUE
pgconn_options(obj)
    VALUE obj;
{
    char *options = PQoptions(get_pgconn(obj));
    if (!options) return Qnil;
    return rb_tainted_str_new2(options);
}

/*
 * call-seq:
 *    conn.tty()
 *
 * Returns the connected pgtty.
 */
static VALUE
pgconn_tty(obj)
    VALUE obj;
{
    char *tty = PQtty(get_pgconn(obj));
    if (!tty) return Qnil;
    return rb_tainted_str_new2(tty);
}

/*
 * call-seq:
 *    conn.user()
 *
 * Returns the authenticated user name.
 */
static VALUE
pgconn_user(obj)
    VALUE obj;
{
    char *user = PQuser(get_pgconn(obj));
    if (!user) return Qnil;
    return rb_tainted_str_new2(user);
}

/*
 * call-seq:
 *    conn.status()
 *
 * MISSING: documentation
 */
static VALUE
pgconn_status(obj)
    VALUE obj;
{
    int status = PQstatus(get_pgconn(obj));
    return INT2NUM(status);
}

/*
 * call-seq:
 *    conn.error()
 *
 * Returns the error message about connection.
 */
static VALUE
pgconn_error(obj)
    VALUE obj;
{
    char *error = PQerrorMessage(get_pgconn(obj));
    if (!error) return Qnil;
    return rb_tainted_str_new2(error);
}

/*
 * call-seq:
 *    conn.trace( port )
 * 
 * Enables tracing message passing between backend.
 * The trace message will be written to the _port_ object,
 * which is an instance of the class +File+.
 */
static VALUE
pgconn_trace(obj, port)
    VALUE obj, port;
{
    OpenFile* fp;

    Check_Type(port, T_FILE);
    GetOpenFile(port, fp);

    PQtrace(get_pgconn(obj), fp->f2?fp->f2:fp->f);

    return obj;
}

/*
 * call-seq:
 *    conn.untrace()
 * 
 * Disables the message tracing.
 */
static VALUE
pgconn_untrace(obj)
    VALUE obj;
{
    PQuntrace(get_pgconn(obj));
    return obj;
}

#ifdef HAVE_PQSETCLIENTENCODING

/*
 * call-seq:
 *    conn.client_encoding() => String
 * 
 * Returns the client encoding as a String.
 */
static VALUE
pgconn_client_encoding(obj)
    VALUE obj;
{
    char *encoding = (char *)pg_encoding_to_char(PQclientEncoding(get_pgconn(obj)));
    return rb_tainted_str_new2(encoding);
}

/*
 * call-seq:
 *    conn.set_client_encoding( encoding )
 * 
 * Sets the client encoding to the _encoding_ String.
 */
static VALUE
pgconn_set_client_encoding(obj, str)
    VALUE obj, str;
{
    Check_Type(str, T_STRING);
    if ((PQsetClientEncoding(get_pgconn(obj), StringValuePtr(str))) == -1){
        rb_raise(rb_ePGError, "invalid encoding name %s",str);
    }
    return Qnil;
}
#endif

static void
free_pgresult(ptr)
    PGresult *ptr;
{
    PQclear(ptr);
}

static VALUE
fetch_pgresult(result, tuple_index, field_index)
    PGresult *result;
    int tuple_index;
    int field_index;
{
    VALUE value;
    if (PQgetisnull(result, tuple_index, field_index) != 1) {
        char * valuestr = PQgetvalue(result, tuple_index, field_index);
        value = rb_tainted_str_new2(valuestr);
    } else {
        value = Qnil;
    }
    return value;
}


static VALUE
pgresult_new(ptr)
    PGresult *ptr;
{
    return Data_Wrap_Struct(rb_cPGresult, 0, free_pgresult, ptr);
}

/*
 * call-seq:
 *    res.status()
 *
 * Returns the status of the query. The status value is one of:
 * * +EMPTY_QUERY+
 * * +COMMAND_OK+
 * * +TUPLES_OK+
 * * +COPY_OUT+
 * * +COPY_IN+
 */
static VALUE
pgresult_status(obj)
    VALUE obj;
{
    int status;

    status = PQresultStatus(get_pgresult(obj));
    return INT2NUM(status);
}

/*
 * call-seq:
 *    res.result()
 *
 * Returns an array of tuples (rows, which are themselves arrays) that represent the query result.
 */

/*
 * call-seq:
 *    res.each{ |tuple| ... }
 *
 * Invokes the block for each tuple (row) in the result.
 *
 * Equivalent to <tt>res.result.each{ |tuple| ... }</tt>.
 */
static VALUE
pgresult_each(self)
    VALUE self;
{
    int i, j;

    PGresult *result = get_pgresult(self);
    int nt = PQntuples(result);
    int nf = PQnfields(result);
    VALUE fields[1] = { rb_ary_new2(nf) };

    for (i = 0; i < nf; i++)
        rb_ary_push(fields[0], rb_tainted_str_new2(PQfname(result, i)));

    for (i=0; i<nt; i++) {
        VALUE row = rb_funcall2(rb_cPGrow, rb_intern("new"), 1, fields);
        for (j=0; j<nf; j++) {
            rb_ary_store(row, j, fetch_pgresult(result, i, j));
        }
        rb_yield(row);
    }

    return self;
}

/*
 * call-seq:
 *    res[ n ]
 *
 * Returns the tuple (row) corresponding to _n_. Returns +nil+ if <tt>_n_ >= res.num_tuples</tt>.
 *
 * Equivalent to <tt>res.result[n]</tt>.
 */
static VALUE
pgresult_aref(argc, argv, obj)
    int argc;
    VALUE *argv;
    VALUE obj;
{
    PGresult *result;
    VALUE a1, a2, val;
    int i, j, nf, nt;

    result = get_pgresult(obj);
    nt = PQntuples(result);
    nf = PQnfields(result);
    switch (rb_scan_args(argc, argv, "11", &a1, &a2)) {
    case 1:
      i = NUM2INT(a1);
      if( i >= nt ) return Qnil;

      val = rb_ary_new();
      for (j=0; j<nf; j++) {
          VALUE value = fetch_pgresult(result, i, j);
          rb_ary_push(val, value);
      }
      return val;

    case 2:
      i = NUM2INT(a1);
      if( i >= nt ) return Qnil;
      j = NUM2INT(a2);
      if( j >= nf ) return Qnil;
      return fetch_pgresult(result, i, j);

    default:
      return Qnil;            /* not reached */
    }
}

/*
 * call-seq:
 *    res.fields()
 *
 * Returns an array of Strings representing the names of the fields in the result.
 *
 *   res=conn.exec("SELECT foo,bar AS biggles,jim,jam FROM mytable;")
 *   res.fields => [ 'foo' , 'biggles' , 'jim' , 'jam' ]
 */
static VALUE
pgresult_fields(obj)
    VALUE obj;
{
    PGresult *result;
    VALUE ary;
    int n, i;

    result = get_pgresult(obj);
    n = PQnfields(result);
    ary = rb_ary_new2(n);
    for (i=0;i<n;i++) {
        rb_ary_push(ary, rb_tainted_str_new2(PQfname(result, i)));
    }
    return ary;
}

/*
 * call-seq:
 *    res.num_tuples()
 *
 * Returns the number of tuples (rows) in the query result.
 *
 * Similar to <tt>res.result.length</tt> (but faster).
 */
static VALUE
pgresult_num_tuples(obj)
    VALUE obj;
{
    int n;

    n = PQntuples(get_pgresult(obj));
    return INT2NUM(n);
}

/*
 * call-seq:
 *    res.num_fields()
 *
 * Returns the number of fields (columns) in the query result.
 *
 * Similar to <tt>res.result[0].length</tt> (but faster).
 */
static VALUE
pgresult_num_fields(obj)
    VALUE obj;
{
    int n;

    n = PQnfields(get_pgresult(obj));
    return INT2NUM(n);
}

/*
 * call-seq:
 *    res.fieldname( index )
 *
 * Returns the name of the field (column) corresponding to the index.
 *
 *   res=conn.exec("SELECT foo,bar AS biggles,jim,jam FROM mytable;")
 *   puts res.fieldname(2) => 'jim'
 *   puts res.fieldname(1) => 'biggles'
 *
 * Equivalent to <tt>res.fields[_index_]</tt>.
 */
static VALUE
pgresult_fieldname(obj, index)
    VALUE obj, index;
{
    PGresult *result;
    int i = NUM2INT(index);
    char *name;

    result = get_pgresult(obj);
    if (i < 0 || i >= PQnfields(result)) {
        rb_raise(rb_eArgError,"invalid field number %d", i);
    }
    name = PQfname(result, i);
    return rb_tainted_str_new2(name);
}

/*
 * call-seq:
 *    res.fieldnum( name )
 *
 * Returns the index of the field specified by the string _name_.
 *
 *   res=conn.exec("SELECT foo,bar AS biggles,jim,jam FROM mytable;")
 *   puts res.fieldnum('foo') => 0
 *
 * Raises an ArgumentError if the specified _name_ isn't one of the field names;
 * raises a TypeError if _name_ is not a String.
 */
static VALUE
pgresult_fieldnum(obj, name)
    VALUE obj, name;
{
    int n;
    
    Check_Type(name, T_STRING);
    
    n = PQfnumber(get_pgresult(obj), StringValuePtr(name));
    if (n == -1) {
        rb_raise(rb_eArgError,"Unknown field: %s", StringValuePtr(name));
    }
    return INT2NUM(n);
}

/*
 * call-seq:
 *    res.type( index )
 *
 * Returns the data type associated with the given column number.
 *
 * The integer returned is the internal +OID+ number (in PostgreSQL) of the type.
 * If you have the PostgreSQL source available, you can see the OIDs for every column type in the file <tt>src/include/catalog/pg_type.h</tt>.
 */
static VALUE
pgresult_type(obj, index)
    VALUE obj, index;
{
    PGresult *result;
    int i = NUM2INT(index);
    int type;

    result = get_pgresult(obj);
    if (i < 0 || i >= PQnfields(result)) {
        rb_raise(rb_eArgError,"invalid field number %d", i);
    }
    type = PQftype(result, i);
    return INT2NUM(type);
}

/*
 * call-seq:
 *    res.size( index )
 *
 * Returns the size of the field type in bytes.  Returns <tt>-1</tt> if the field is variable sized.
 *
 *   res = conn.exec("SELECT myInt, myVarChar50 FROM foo;")
 *   res.size(0) => 4
 *   res.size(1) => -1
 */
static VALUE
pgresult_size(obj, index)
    VALUE obj, index;
{
    PGresult *result;
    int i = NUM2INT(index);
    int size;

    result = get_pgresult(obj);
    if (i < 0 || i >= PQnfields(result)) {
        rb_raise(rb_eArgError,"invalid field number %d", i);
    }
    size = PQfsize(result, i);
    return INT2NUM(size);
}

/*
 * call-seq:
 *    res.value( tup_num, field_num )
 *
 * Returns the value in tuple number <i>tup_num</i>, field number <i>field_num</i>. (Row <i>tup_num</i>, column <i>field_num</i>.)
 *
 * Equivalent to <tt>res.result[<i>tup_num</i>][<i>field_num</i>]</tt> (but faster).
 */
static VALUE
pgresult_getvalue(obj, tup_num, field_num)
    VALUE obj, tup_num, field_num;
{
    PGresult *result;
    int i = NUM2INT(tup_num);
    int j = NUM2INT(field_num);

    result = get_pgresult(obj);
    if (i < 0 || i >= PQntuples(result)) {
        rb_raise(rb_eArgError,"invalid tuple number %d", i);
    }
    if (j < 0 || j >= PQnfields(result)) {
        rb_raise(rb_eArgError,"invalid field number %d", j);
    }

    return fetch_pgresult(result, i, j);
}


/*
 * call-seq:
 *    res.value_byname( tup_num, field_name )
 *
 * Returns the value in tuple number <i>tup_num</i>, for the field named <i>field_name</i>.
 *
 * Equivalent to (but faster than) either of:
 *    res.result[<i>tup_num</i>][ res.fieldnum(<i>field_name</i>) ]
 *    res.value( <i>tup_num</i>, res.fieldnum(<i>field_name</i>) )
 *
 * <i>(This method internally calls #value as like the second example above; it is slower than using the field index directly.)</i>
 */
static VALUE
pgresult_getvalue_byname(obj, tup_num, field_name)
    VALUE obj, tup_num, field_name;
{
    return pgresult_getvalue(obj, tup_num, pgresult_fieldnum(obj, field_name));
}


/*
 * call-seq:
 *    res.getlength( tup_num, field_num )
 *
 * Returns the (String) length of the field in bytes.
 *
 * Equivalent to <tt>res.value(<i>tup_num</i>,<i>field_num</i>).length</tt>.
 */
static VALUE
pgresult_getlength(obj, tup_num, field_num)
    VALUE obj, tup_num, field_num;
{
    PGresult *result;
    int i = NUM2INT(tup_num);
    int j = NUM2INT(field_num);

    result = get_pgresult(obj);
    if (i < 0 || i >= PQntuples(result)) {
        rb_raise(rb_eArgError,"invalid tuple number %d", i);
    }
    if (j < 0 || j >= PQnfields(result)) {
        rb_raise(rb_eArgError,"invalid field number %d", j);
    }
    return INT2FIX(PQgetlength(result, i, j));
}

/*
 * call-seq:
 *    res.getisnull( tup_num, field_num ) => true or false
 *
 * Returns +true+ if the specified value is +nil+; +false+ otherwise.
 *
 * Equivalent to <tt>res.value(<i>tup_num</i>,<i>field_num</i>)==+nil+</tt>.
 */
static VALUE
pgresult_getisnull(obj, tup_num, field_num)
    VALUE obj, tup_num, field_num;
{
    PGresult *result;
    int i = NUM2INT(tup_num);
    int j = NUM2INT(field_num);

    result = get_pgresult(obj);
    if (i < 0 || i >= PQntuples(result)) {
        rb_raise(rb_eArgError,"invalid tuple number %d", i);
    }
    if (j < 0 || j >= PQnfields(result)) {
        rb_raise(rb_eArgError,"invalid field number %d", j);
    }
    return PQgetisnull(result, i, j) ? Qtrue : Qfalse;
}

/*
 * call-seq:
 *    res.print( file, opt )
 *
 * MISSING: Documentation
 */
static VALUE
pgresult_print(obj, file, opt)
    VALUE obj, file, opt;
{
    VALUE value;
    ID mem;
    OpenFile* fp;
    PQprintOpt po;

    Check_Type(file, T_FILE);
    Check_Type(opt,  T_STRUCT);
    GetOpenFile(file, fp);

    memset(&po, 0, sizeof(po));

    mem = rb_intern("header");
    value = rb_struct_getmember(opt, mem);
    po.header = value == Qtrue ? 1 : 0;

    mem = rb_intern("align");
    value = rb_struct_getmember(opt, mem);
    po.align = value == Qtrue ? 1 : 0;

    mem = rb_intern("standard");
    value = rb_struct_getmember(opt, mem);
    po.standard = value == Qtrue ? 1 : 0;

    mem = rb_intern("html3");
    value = rb_struct_getmember(opt, mem);
    po.html3 = value == Qtrue ? 1 : 0;

    mem = rb_intern("expanded");
    value = rb_struct_getmember(opt, mem);
    po.expanded = value == Qtrue ? 1 : 0;

    mem = rb_intern("pager");
    value = rb_struct_getmember(opt, mem);
    po.pager = value == Qtrue ? 1 : 0;

    mem = rb_intern("fieldSep");
    value = rb_struct_getmember(opt, mem);
    if (!NIL_P(value)) {
        Check_Type(value, T_STRING);
        po.fieldSep = StringValuePtr(value);
    }

    mem = rb_intern("tableOpt");
    value = rb_struct_getmember(opt, mem);
    if (!NIL_P(value)) {
        Check_Type(value, T_STRING);
        po.tableOpt = StringValuePtr(value);
    }

    mem = rb_intern("caption");
    value = rb_struct_getmember(opt, mem);
    if (!NIL_P(value)) {
        Check_Type(value, T_STRING);
        po.caption = StringValuePtr(value);
    }

    PQprint(fp->f2?fp->f2:fp->f, get_pgresult(obj), &po);
    return obj;
}

/*
 * call-seq:
 *    res.cmdtuples()
 *
 * Returns the number of tuples (rows) affected by the SQL command.
 *
 * If the SQL command that generated the PGresult was not one of +INSERT+, +UPDATE+, +DELETE+, +MOVE+, or +FETCH+, or if no tuples (rows) were affected, +0+ is returned.
 */
static VALUE
pgresult_cmdtuples(obj)
    VALUE obj;
{
    long n;
    n = strtol(PQcmdTuples(get_pgresult(obj)),NULL, 10);
    return INT2NUM(n);
}
/*
 * call-seq:
 *    res.cmdstatus()
 *
 * Returns the status string of the last query command.
 */
static VALUE
pgresult_cmdstatus(obj)
    VALUE obj;
{
    return rb_tainted_str_new2(PQcmdStatus(get_pgresult(obj)));
}

/*
 * call-seq:
 *    res.oid()
 *
 * Returns the +oid+.
 */
static VALUE
pgresult_oid(obj)
    VALUE obj;
{
    Oid n = PQoidValue(get_pgresult(obj));
    if (n == InvalidOid)
        return Qnil;
    else
        return INT2NUM(n);
}

/*
 * call-seq:
 *    res.clear()
 *
 * Clears the PGresult object as the result of the query.
 */
static VALUE
pgresult_clear(obj)
    VALUE obj;
{
    PQclear(get_pgresult(obj));
    DATA_PTR(obj) = 0;

    return Qnil;
}

static VALUE
pgresult_result_with_clear(self)
    VALUE self;
{
    VALUE rows = rb_funcall(self, rb_intern("rows"), 0);
    pgresult_clear(self);
    return rows;
}

/* Large Object support */
static PGlarge*
get_pglarge(obj)
    VALUE obj;
{
    PGlarge *pglarge;
    Data_Get_Struct(obj, PGlarge, pglarge);
    if (pglarge == 0) rb_raise(rb_ePGError, "invalid large object");
    return pglarge;
}

/*
 * call-seq:
 *    conn.lo_import( file ) => pglarge
 *
 * Import a file to a large object. Returns a PGlarge instance on success. On failure, it raises a PGError exception.
 */
static VALUE
pgconn_loimport(obj, filename)
    VALUE obj, filename;
{
    Oid lo_oid;

    PGconn *conn = get_pgconn(obj);

    Check_Type(filename, T_STRING);

    lo_oid = lo_import(conn, StringValuePtr(filename));
    if (lo_oid == 0) {
        rb_raise(rb_ePGError, PQerrorMessage(conn));
    }
    return pglarge_new(conn, lo_oid, -1);
}

/*
 * call-seq:
 *    conn.lo_export( oid, file )
 *
 * Saves a large object of _oid_ to a _file_.
 */
static VALUE
pgconn_loexport(obj, lo_oid,filename)
    VALUE obj, lo_oid, filename;
{
    PGconn *conn = get_pgconn(obj);
    int oid;
    Check_Type(filename, T_STRING);

    oid = NUM2INT(lo_oid);
    if (oid < 0) {
        rb_raise(rb_ePGError, "invalid large object oid %d",oid);
    }

    if (!lo_export(conn, oid, StringValuePtr(filename))) {
        rb_raise(rb_ePGError, PQerrorMessage(conn));
    }
    return Qnil;
}

/*
 * call-seq:
 *    conn.lo_create( [mode] ) => pglarge
 *
 * Returns a PGlarge instance on success. On failure, it raises PGError exception.
 * <i>(See #lo_open for information on _mode_.)</i>
 */
static VALUE
pgconn_locreate(argc, argv, obj)
    int argc;
    VALUE *argv;
    VALUE obj;
{
    Oid lo_oid;
    int mode;
    VALUE nmode;
    PGconn *conn;
    
    if (rb_scan_args(argc, argv, "01", &nmode) == 0) {
        mode = INV_READ;
    }
    else {
        mode = FIX2INT(nmode);
    }
  
    conn = get_pgconn(obj);
    lo_oid = lo_creat(conn, mode);
    if (lo_oid == 0){
        rb_raise(rb_ePGError, "can't creat large object");
    }

    return pglarge_new(conn, lo_oid, -1);
}

/*
 * call-seq:
 *    conn.lo_open( oid, [mode] ) => pglarge
 *
 * Open a large object of _oid_. Returns a PGlarge instance on success.
 * The _mode_ argument specifies the mode for the opened large object,
 * which is either +INV_READ+, or +INV_WRITE+.
 * * If _mode_ On failure, it raises a PGError exception.
 * * If _mode_ is omitted, the default is +INV_READ+.
 */
static VALUE
pgconn_loopen(argc, argv, obj)
    int argc;
    VALUE *argv;
    VALUE obj;
{
    Oid lo_oid;
    int fd, mode;
    VALUE nmode, objid;
    PGconn *conn = get_pgconn(obj);

    switch (rb_scan_args(argc, argv, "02", &objid, &nmode)) {
    case 1:
      lo_oid = NUM2INT(objid);
      mode = INV_READ;
      break;
    case 2:
      lo_oid = NUM2INT(objid);
      mode = FIX2INT(nmode);
      break;
    default:
      mode = INV_READ;
      lo_oid = lo_creat(conn, mode);
      if (lo_oid == 0){
          rb_raise(rb_ePGError, "can't creat large object");
      }
    }
    if((fd = lo_open(conn, lo_oid, mode)) < 0) {
        rb_raise(rb_ePGError, "can't open large object");
    }
    return pglarge_new(conn, lo_oid, fd);
}

/*
 * call-seq:
 *    conn.lo_unlink( oid )
 *
 * Unlinks (deletes) the postgres large object of _oid_.
 */
static VALUE
pgconn_lounlink(obj, lo_oid)
    VALUE obj, lo_oid;
{
    PGconn *conn;
    int oid = NUM2INT(lo_oid);
    int result;
    
    if (oid < 0){
        rb_raise(rb_ePGError, "invalid oid %d",oid);
    }
    conn = get_pgconn(obj);
    result = lo_unlink(conn,oid);

    return Qnil;
}

static void
free_pglarge(ptr)
    PGlarge *ptr;
{
    if ((ptr->lo_fd) > 0) {
        lo_close(ptr->pgconn,ptr->lo_fd);
    }
    free(ptr);
}

static VALUE
pglarge_new(conn, lo_oid ,lo_fd)
    PGconn *conn;
    Oid lo_oid;
    int lo_fd;
{
    VALUE obj;
    PGlarge *pglarge;

    obj = Data_Make_Struct(rb_cPGlarge, PGlarge, 0, free_pglarge, pglarge);
    pglarge->pgconn = conn;
    pglarge->lo_oid = lo_oid;
    pglarge->lo_fd = lo_fd;

    return obj;
}

/*
 * call-seq:
 *    lrg.oid()
 *
 * Returns the large object's +oid+.
 */
static VALUE
pglarge_oid(obj)
    VALUE obj;
{
    PGlarge *pglarge = get_pglarge(obj);

    return INT2NUM(pglarge->lo_oid);
}

/*
 * call-seq:
 *    lrg.open( [mode] )
 *
 * Opens a large object.
 * The _mode_ argument specifies the mode for the opened large object,
 * which is either +INV_READ+ or +INV_WRITE+.
 */
static VALUE
pglarge_open(argc, argv, obj)
    int argc;
    VALUE *argv;
    VALUE obj;
{
    PGlarge *pglarge = get_pglarge(obj);
    VALUE nmode;
    int fd;
    int mode;

    if (rb_scan_args(argc, argv, "01", &nmode) == 0) {
        mode = INV_READ;
    }
    else {
        mode = FIX2INT(nmode);
    }
  
    if((fd = lo_open(pglarge->pgconn, pglarge->lo_oid, mode)) < 0) {
        rb_raise(rb_ePGError, "can't open large object");
    }
    pglarge->lo_fd = fd;

    return INT2FIX(pglarge->lo_fd);
}

/*
 * call-seq:
 *    lrg.close()
 *
 * Closes a large object. Closed when they are garbage-collected.
 */
static VALUE
pglarge_close(obj)
    VALUE obj;
{
    PGlarge *pglarge = get_pglarge(obj);

    if((lo_close(pglarge->pgconn, pglarge->lo_fd)) < 0) {
        rb_raise(rb_ePGError, "can't closed large object");
    }
    DATA_PTR(obj) = 0;
  
    return Qnil;
}

/*
 * call-seq:
 *    lrg.tell()
 *
 * Returns the current position of the large object pointer.
 */
static VALUE
pglarge_tell(obj)
    VALUE obj;
{
    int start;
    PGlarge *pglarge = get_pglarge(obj);

    if ((start = lo_tell(pglarge->pgconn,pglarge->lo_fd)) == -1) {
        rb_raise(rb_ePGError, "error while getting position");
    }
    return INT2NUM(start);
}

static VALUE
loread_all(obj)
    VALUE obj;
{
    PGlarge *pglarge = get_pglarge(obj);
    VALUE str;
    long siz = BUFSIZ;
    long bytes = 0;
    int n;

    str = rb_tainted_str_new(0,siz);
    for (;;) {
        n = lo_read(pglarge->pgconn, pglarge->lo_fd, RSTRING(str)->ptr + bytes,siz - bytes);
        if (n == 0 && bytes == 0) return Qnil;
        bytes += n;
        if (bytes < siz ) break;
        siz += BUFSIZ;
        rb_str_resize(str,siz);
    }
    if (bytes == 0) return rb_tainted_str_new(0,0);
    if (bytes != siz) rb_str_resize(str, bytes);
    return str;
}

/*
 * call-seq:
 *    lrg.read( [length] )
 *
 * Attempts to read _length_ bytes from large object.
 * If no _length_ is given, reads all data.
 */
static VALUE
pglarge_read(argc, argv, obj)
    int argc;
    VALUE *argv;
    VALUE obj;
{
    int len;
    PGlarge *pglarge = get_pglarge(obj);
    VALUE str;
    VALUE length;
    
    rb_scan_args(argc, argv, "01", &length);
    if (NIL_P(length)) {
        return loread_all(obj);
    }
    
    len = NUM2INT(length);
    if (len < 0){
        rb_raise(rb_ePGError,"nagative length %d given", len);
    }
    str = rb_tainted_str_new(0,len);

    if((len = lo_read(pglarge->pgconn, pglarge->lo_fd, StringValuePtr(str), len)) < 0) {
        rb_raise(rb_ePGError, "error while reading");
    }
    if (len == 0) return Qnil;
    RSTRING(str)->len = len;
    return str;
}

/*
 * call-seq:
 *    lrg.write( str )
 *
 * Writes the string _str_ to the large object.
 * Returns the number of bytes written.
 */
static VALUE
pglarge_write(obj, buffer)
    VALUE obj, buffer;
{
    int n;
    PGlarge *pglarge = get_pglarge(obj);

    Check_Type(buffer, T_STRING);

    if( RSTRING(buffer)->len < 0) {
        rb_raise(rb_ePGError, "write buffer zero string");
    }
    if((n = lo_write(pglarge->pgconn, pglarge->lo_fd, StringValuePtr(buffer), RSTRING(buffer)->len)) == -1) {
        rb_raise(rb_ePGError, "buffer truncated during write");
    }
  
    return INT2FIX(n);
}

/*
 * call-seq:
 *    lrg.seek( offset, whence )
 *
 * Move the large object pointer to the _offset_.
 * Valid values for _whence_ are +SEEK_SET+, +SEEK_CUR+, and +SEEK_END+.
 * (Or 0, 1, or 2.)
 */
static VALUE
pglarge_seek(obj, offset, whence)
    VALUE obj, offset, whence;
{
    PGlarge *pglarge = get_pglarge(obj);
    int ret;
    
    if((ret = lo_lseek(pglarge->pgconn, pglarge->lo_fd, NUM2INT(offset), NUM2INT(whence))) == -1) {
        rb_raise(rb_ePGError, "error while moving cursor");
    }

    return INT2NUM(ret);
}

/*
 * call-seq:
 *    lrg.size()
 *
 * Returns the size of the large object.
 */
static VALUE
pglarge_size(obj)
    VALUE obj;
{
    PGlarge *pglarge = get_pglarge(obj);
    int start, end;

    if ((start = lo_tell(pglarge->pgconn,pglarge->lo_fd)) == -1) {
        rb_raise(rb_ePGError, "error while getting position");
    }

    if ((end = lo_lseek(pglarge->pgconn, pglarge->lo_fd, 0, SEEK_END)) == -1) {
        rb_raise(rb_ePGError, "error while moving cursor");
    }

    if ((start = lo_lseek(pglarge->pgconn, pglarge->lo_fd,start, SEEK_SET)) == -1) {
        rb_raise(rb_ePGError, "error while moving back to posiion");
    }
        
    return INT2NUM(end);
}
    
/*
 * call-seq:
 *    lrg.export( file )
 *
 * Saves the large object to a file.
 */
static VALUE
pglarge_export(obj, filename)
    VALUE obj, filename;
{
    PGlarge *pglarge = get_pglarge(obj);

    Check_Type(filename, T_STRING);

    if (!lo_export(pglarge->pgconn, pglarge->lo_oid, StringValuePtr(filename))){
        rb_raise(rb_ePGError, PQerrorMessage(pglarge->pgconn));
    }

    return Qnil;
}

/*
 * call-seq:
 *    lrg.unlink()
 *
 * Deletes the large object.
 */
static VALUE
pglarge_unlink(obj)
    VALUE obj;
{
    PGlarge *pglarge = get_pglarge(obj);

    if (!lo_unlink(pglarge->pgconn,pglarge->lo_oid)) {
        rb_raise(rb_ePGError, PQerrorMessage(pglarge->pgconn));
    }
    DATA_PTR(obj) = 0;

    return Qnil;
}

static VALUE
pgrow_init(self, keys)
    VALUE self, keys;
{
    VALUE args[1] = { LONG2NUM(RARRAY(keys)->len) };
    rb_call_super(1, args);
    rb_iv_set(self, "@keys", keys);
    return self;
}

static VALUE
pgrow_keys(self)
    VALUE self;
{
    return rb_iv_get(self, "@keys");
}

static VALUE
pgrow_values(self)
    VALUE self;
{
    return self;
}

static VALUE
pgrow_aref(argc, argv, self)
    int argc;
    VALUE * argv;
    VALUE self;
{
    if (TYPE(argv[0]) == T_STRING) {
        VALUE keys = pgrow_keys(self);
        int index = NUM2INT(rb_funcall(keys, rb_intern("index"), 1, argv[0]));
        return rb_ary_entry(self, index);
    }
    else {
        return rb_call_super(argc, argv);
    }
}

static VALUE
pgrow_each_value(self)
    VALUE self;
{
    rb_ary_each(self);
}

static VALUE
pgrow_each_pair(self)
    VALUE self;
{
    VALUE keys = pgrow_keys(self);
    int i;
    for (i = 0; i < RARRAY(keys)->len; ++i) {
        rb_yield(rb_assoc_new(rb_ary_entry(keys, i), rb_ary_entry(self, i)));
    }
    return self;
}

static VALUE
pgrow_each(self)
    VALUE self;
{
    int arity = NUM2INT(rb_funcall(rb_block_proc(), rb_intern("arity"), 0));
    if (arity == 2) {
        pgrow_each_pair(self);
    }
    else {
        pgrow_each_value(self);
    }
    return self;
}

static VALUE
pgrow_each_key(self)
    VALUE self;
{
    rb_ary_each(pgrow_keys(self));
}

static VALUE
pgrow_to_hash(self)
    VALUE self;
{
    VALUE result = rb_hash_new();
    VALUE keys = pgrow_keys(self);
    int i;
    for (i = 0; i < RARRAY(self)->len; ++i) {
        rb_hash_aset(result, rb_ary_entry(keys, i), rb_ary_entry(self, i));
    }
    return result;
}

/* Large Object support */

/********************************************************************
 * 
 * Document-class: PGconn
 *
 * The class to access PostgreSQL database.
 * All other functionality of libpq save the large object to a file.
 *
 * For example, to send query to the database on the localhost:
 *    require "postgres"
 *    conn = PGconn.connect("localhost", 5432, "", "", "test1")
 *    res  = conn.exec("select * from a;")
 *
 * See the PGresult class for information on working with the results of a query.
 */


/********************************************************************
 * 
 * Document-class: PGresult
 *
 * The class to represent the query result tuples (rows). 
 * An instance of this class is created as the result of every query.
 * You may need to invoke the #clear method of the instance when finished with
 * the result for better memory performance.
 */



/********************************************************************
 * 
 * Document-class: PGlarge
 *
 * The class to access large objects.
 * An instance of this class is created as the  result of
 * PGconn#lo_import, PGconn#lo_create, and PGconn#lo_open.
 */

void
Init_postgres()
{
    pg_gsub_bang_id = rb_intern("gsub!");
    pg_escape_regex = rb_reg_new("([\\t\\n\\\\])",10,0);
    rb_global_variable(&pg_escape_regex);
    pg_escape_str = rb_str_new("\\\\\\1",4);
    rb_global_variable(&pg_escape_str);

    rb_ePGError = rb_define_class("PGError", rb_eStandardError);

    rb_cPGconn = rb_define_class("PGconn", rb_cObject);
#ifdef HAVE_RB_DEFINE_ALLOC_FUNC
    rb_define_alloc_func(rb_cPGconn, pgconn_alloc);
#else
    rb_define_singleton_method(rb_cPGconn, "new", pgconn_s_new, -1);
#endif  
    rb_define_singleton_method(rb_cPGconn, "connect", pgconn_s_connect, -1);
    rb_define_singleton_method(rb_cPGconn, "open", pgconn_s_connect, -1);
    rb_define_singleton_method(rb_cPGconn, "setdb", pgconn_s_connect, -1);
    rb_define_singleton_method(rb_cPGconn, "setdblogin", pgconn_s_connect, -1);
    rb_define_singleton_method(rb_cPGconn, "escape", pgconn_s_escape, 1);
    rb_define_singleton_method(rb_cPGconn, "quote", pgconn_s_quote, 1);
    rb_define_singleton_method(rb_cPGconn, "escape_bytea", pgconn_s_escape_bytea, 1);
    rb_define_singleton_method(rb_cPGconn, "unescape_bytea", pgconn_s_unescape_bytea, 1);

    rb_define_const(rb_cPGconn, "CONNECTION_OK", INT2FIX(CONNECTION_OK));
    rb_define_const(rb_cPGconn, "CONNECTION_BAD", INT2FIX(CONNECTION_BAD));

    rb_define_method(rb_cPGconn, "initialize", pgconn_init, -1);    
    rb_define_method(rb_cPGconn, "db", pgconn_db, 0);
    rb_define_method(rb_cPGconn, "host", pgconn_host, 0);
    rb_define_method(rb_cPGconn, "options", pgconn_options, 0);
    rb_define_method(rb_cPGconn, "port", pgconn_port, 0);
    rb_define_method(rb_cPGconn, "tty", pgconn_tty, 0);
    rb_define_method(rb_cPGconn, "status", pgconn_status, 0);
    rb_define_method(rb_cPGconn, "error", pgconn_error, 0);
    rb_define_method(rb_cPGconn, "close", pgconn_close, 0);
    rb_define_alias(rb_cPGconn, "finish", "close");
    rb_define_method(rb_cPGconn, "reset", pgconn_reset, 0);
    rb_define_method(rb_cPGconn, "user", pgconn_user, 0);
    rb_define_method(rb_cPGconn, "trace", pgconn_trace, 1);
    rb_define_method(rb_cPGconn, "untrace", pgconn_untrace, 0);
    rb_define_method(rb_cPGconn, "exec", pgconn_exec, 1);
    rb_define_method(rb_cPGconn, "query", pgconn_query, 1);
    rb_define_method(rb_cPGconn, "async_exec", pgconn_async_exec, 1);
    rb_define_method(rb_cPGconn, "async_query", pgconn_async_query, 1);
    rb_define_method(rb_cPGconn, "get_notify", pgconn_get_notify, 0);
    rb_define_method(rb_cPGconn, "insert_table", pgconn_insert_table, 2);
    rb_define_method(rb_cPGconn, "putline", pgconn_putline, 1);
    rb_define_method(rb_cPGconn, "getline", pgconn_getline, 0);
    rb_define_method(rb_cPGconn, "endcopy", pgconn_endcopy, 0);
    rb_define_method(rb_cPGconn, "notifies", pgconn_notifies, 0);
    rb_define_method(rb_cPGconn, "on_notice", pgconn_on_notice, 0);

#ifdef HAVE_PQSETCLIENTENCODING
    rb_define_method(rb_cPGconn, "client_encoding",pgconn_client_encoding, 0);
    rb_define_method(rb_cPGconn, "set_client_encoding",pgconn_set_client_encoding, 1);
#endif    


    /* Large Object support */
    rb_define_method(rb_cPGconn, "lo_import", pgconn_loimport, 1);
    rb_define_alias(rb_cPGconn, "loimport", "lo_import");
    rb_define_method(rb_cPGconn, "lo_create", pgconn_locreate, -1);
    rb_define_alias(rb_cPGconn, "locreate", "lo_create");
    rb_define_method(rb_cPGconn, "lo_open", pgconn_loopen, -1);
    rb_define_alias(rb_cPGconn, "loopen", "lo_open");
    rb_define_method(rb_cPGconn, "lo_export", pgconn_loexport, 2);
    rb_define_alias(rb_cPGconn, "loexport", "lo_export");
    rb_define_method(rb_cPGconn, "lo_unlink", pgconn_lounlink, 1);
    rb_define_alias(rb_cPGconn, "lounlink", "lo_unlink");
    
    rb_cPGlarge = rb_define_class("PGlarge", rb_cObject);
    rb_define_method(rb_cPGlarge, "oid",pglarge_oid, 0);
    rb_define_method(rb_cPGlarge, "open",pglarge_open, -1);
    rb_define_method(rb_cPGlarge, "close",pglarge_close, 0);
    rb_define_method(rb_cPGlarge, "read",pglarge_read, -1);
    rb_define_method(rb_cPGlarge, "write",pglarge_write, 1);
    rb_define_method(rb_cPGlarge, "seek",pglarge_seek, 2);
    rb_define_method(rb_cPGlarge, "tell",pglarge_tell, 0);
    rb_define_method(rb_cPGlarge, "size",pglarge_size, 0);
    rb_define_method(rb_cPGlarge, "export",pglarge_export, 1);
    rb_define_method(rb_cPGlarge, "unlink",pglarge_unlink, 0);

    rb_define_const(rb_cPGlarge, "INV_WRITE", INT2FIX(INV_WRITE));
    rb_define_const(rb_cPGlarge, "INV_READ", INT2FIX(INV_READ));
    rb_define_const(rb_cPGlarge, "SEEK_SET", INT2FIX(SEEK_SET));
    rb_define_const(rb_cPGlarge, "SEEK_CUR", INT2FIX(SEEK_CUR));
    rb_define_const(rb_cPGlarge, "SEEK_END", INT2FIX(SEEK_END));
    /* Large Object support */
    
    rb_cPGresult = rb_define_class("PGresult", rb_cObject);
    rb_include_module(rb_cPGresult, rb_mEnumerable);

    rb_define_const(rb_cPGresult, "EMPTY_QUERY", INT2FIX(PGRES_EMPTY_QUERY));
    rb_define_const(rb_cPGresult, "COMMAND_OK", INT2FIX(PGRES_COMMAND_OK));
    rb_define_const(rb_cPGresult, "TUPLES_OK", INT2FIX(PGRES_TUPLES_OK));
    rb_define_const(rb_cPGresult, "COPY_OUT", INT2FIX(PGRES_COPY_OUT));
    rb_define_const(rb_cPGresult, "COPY_IN", INT2FIX(PGRES_COPY_IN));
    rb_define_const(rb_cPGresult, "BAD_RESPONSE", INT2FIX(PGRES_BAD_RESPONSE));
    rb_define_const(rb_cPGresult, "NONFATAL_ERROR",INT2FIX(PGRES_NONFATAL_ERROR));
    rb_define_const(rb_cPGresult, "FATAL_ERROR", INT2FIX(PGRES_FATAL_ERROR));

    rb_define_method(rb_cPGresult, "status", pgresult_status, 0);
    rb_define_alias(rb_cPGresult, "result", "entries");
    rb_define_alias(rb_cPGresult, "rows", "entries");
    rb_define_method(rb_cPGresult, "each", pgresult_each, 0);
    rb_define_method(rb_cPGresult, "[]", pgresult_aref, -1);
    rb_define_method(rb_cPGresult, "fields", pgresult_fields, 0);
    rb_define_method(rb_cPGresult, "num_tuples", pgresult_num_tuples, 0);
    rb_define_method(rb_cPGresult, "num_fields", pgresult_num_fields, 0);
    rb_define_method(rb_cPGresult, "fieldname", pgresult_fieldname, 1);
    rb_define_method(rb_cPGresult, "fieldnum", pgresult_fieldnum, 1);
    rb_define_method(rb_cPGresult, "type", pgresult_type, 1);
    rb_define_method(rb_cPGresult, "size", pgresult_size, 1);
    rb_define_method(rb_cPGresult, "getvalue", pgresult_getvalue, 2);
    rb_define_method(rb_cPGresult, "getvalue_byname", pgresult_getvalue_byname, 2);
    rb_define_method(rb_cPGresult, "getlength", pgresult_getlength, 2);
    rb_define_method(rb_cPGresult, "getisnull", pgresult_getisnull, 2);
    rb_define_method(rb_cPGresult, "cmdtuples", pgresult_cmdtuples, 0);
    rb_define_method(rb_cPGresult, "cmdstatus", pgresult_cmdstatus, 0);
    rb_define_method(rb_cPGresult, "oid", pgresult_oid, 0);
    rb_define_method(rb_cPGresult, "print", pgresult_print, 2);
    rb_define_method(rb_cPGresult, "clear", pgresult_clear, 0);
    rb_define_alias(rb_cPGresult, "close", "clear");

    rb_cPGrow = rb_define_class("PGrow", rb_cArray);
    rb_define_method(rb_cPGrow, "initialize", pgrow_init, 1);
    rb_define_method(rb_cPGrow, "[]", pgrow_aref, -1);
    rb_define_method(rb_cPGrow, "keys", pgrow_keys, 0);
    rb_define_method(rb_cPGrow, "values", pgrow_values, 0);
    rb_define_method(rb_cPGrow, "each", pgrow_each, 0);
    rb_define_method(rb_cPGrow, "each_pair", pgrow_each_pair, 0);
    rb_define_method(rb_cPGrow, "each_key", pgrow_each_key, 0);
    rb_define_method(rb_cPGrow, "each_value", pgrow_each_value, 0);
    rb_define_method(rb_cPGrow, "to_hash", pgrow_to_hash, 0); 
}
