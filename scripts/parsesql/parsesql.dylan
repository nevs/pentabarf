module: parsesql
synopsis: 
author: Sven Klemm
copyright: 

define class <database-table> (<object>)
  slot table-name :: <string>, required-init-keyword: name:;
  slot fields :: <list>;
end class <database-table>;

define class <datatype> (<object>)
  slot field-name :: <string>, required-init-keyword: name:;
  slot datatype :: <string>;
  slot primary-key? :: <boolean> = #f;
  slot not-null? :: <boolean> = #f;
end class <datatype>;

define function parse-sql( sql :: <string>, table :: <database-table> ) => ()
  let match = regexp-position( sql, "^ *([-a-z0-9_]+) +([A-Z]+(\\([0-9,]+\\))?).*$" );
  if ( match )
    // we got an ordinary field definition
    if ( regexp-position( sql, "INTEGER" ) )
      //
    elseif ( regexp-position( sql, "VARCHAR") )
      //
    end if;
  else
    // no explicit field definition
  end if;
end function;


define function main(name, arguments)
  let sqlfile = make( <file-stream>, locator: "tables.sql", direction: #"input" );
  block (return)
    for (while: #t)
      let zeile = read-line(sqlfile, on-end-of-stream: #f);
      if ( zeile )
        if (regexp-position(zeile , "CREATE TABLE"))
          write-line(*standard-output*, zeile);
          block(table-end)
            let table = make( <database-table>, name: "test" );
            for ( while: #t )
              // inner loop for tables 
              let zeile = read-line(sqlfile, on-end-of-stream: #f);
              if (zeile) 
                if (regexp-position(zeile, ";") )
                  table-end();
                else
                  write-line(*standard-output*, zeile);
                end if;
              else
                return("end of file");
              end if;
            end for;
          cleanup
            // write the file for the current table
          end block;
        end if;
      else
        return();
      end if;
    end for;
  cleanup
    close( sqlfile );
  end block;
  force-output(*standard-output*);
  exit-application(0);
end function main;

// Invoke our main() function.
main( application-name(), application-arguments() );

