if RUBY_VERSION < "1.3"
  print "This library is for ruby-1.3 or higher.\n"
  exit 1
end

require "mkmf"

def pg_config(type)
  require 'open3'
  stdin, stdout, stderr = Open3.popen3("pg_config --#{type}dir")
  stdout.readline.chomp rescue nil
end

dir_config('pgsql')

$CFLAGS = ""
$LDFLAGS = ""

have_library("wsock32", "cygwin32_socket") or have_library("socket", "socket")
have_library("inet", "gethostbyname")
have_library("nsl", "gethostbyname")
have_header("sys/un.h")
if have_func("socket") or have_func("cygwin32_socket")
  have_func("hsterror")
  unless have_func("gethostname")
    have_func("uname")
  end
  if ENV["SOCKS_SERVER"]  # test if SOCKSsocket needed
    if have_library("socks", "Rconnect")
      $CFLAGS+="-DSOCKS"
    end
  end
  have_library("crypto", "BIO_free")
  have_library("ssl", "SSL_connect")
  incdir = with_config("pgsql-include-dir")
  incdir ||= ENV["POSTGRES_INCLUDE"]
  incdir ||= pg_config('include')
  if incdir
    $CFLAGS += "-I#{incdir}"
    puts "Using PostgreSQL include directory: #{incdir}"
  end
  libdir = with_config("pgsql-lib-dir")
  libdir ||= ENV["POSTGRES_LIB"]
  libdir ||= pg_config('lib')
  if libdir
    $LDFLAGS += "-L#{libdir}"
    puts "Using PostgreSQL lib directory: #{libdir}"
  end
  if have_library("pq", "PQsetdbLogin") &&
    have_header("libpq-fe.h") &&
    have_header("libpq/libpq-fs.h")
    $objs = %w(postgres.o)
    have_func("PQsetClientEncoding")
    have_func("pg_encoding_to_char")
    $objs << 'libpq-compat.o' unless have_func("PQescapeString")
    have_func("PQfreemem")
    create_makefile("postgres")
  else
    puts "Could not find PostgreSQL libraries: Makefile not created"    
  end
end
