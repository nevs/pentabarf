#!/usr/bin/perl

use warnings;

open(SQLFILE, "tables.sql") or die "Couldn't open sql-file: $!";

while (<SQLFILE>) {
  next if (m!^ *$!);
  next if (m!^BEGIN; *$!);
  next if (m!^COMMIT; *$!);
  if (m!^CREATE TABLE ([a-z_0-9]+) +\( *$!) {
    my $tablename = $1;
    while (<SQLFILE>) {
      next if (m!^ *FOREIGN KEY .*$!);
      next if (m!^ *UNIQUE.*!);

      if (m!^ *PRIMARY KEY +\(([a-z_0-9, ]+)\) *$!) {
        @pkeys = split(/, */,$1);
        while($field = shift(@pkeys)) 
        {
          push(@field_pkey, "    \$this->field['$field']['primary_key'] = true;\n");
        }
        next;
      }
      if (m!^ *([-a-z0-9_]+) +([A-Z]+(\([0-9,]+\))?).*$!) {
        $fieldname = $1;
        $datatype = $2;
        if (m!.*NOT NULL.*!) {
          $not_null = 1;
        } else {
          $not_null = 0;
        }
        if (m!.*DEFAULT.*!) {
          $default = 1;
        } else {
          $default = 0;
        }
        
        if ( $not_null == 1 || $default == 1 )
        {
          if ($not_null) {
            $properties = "'NOT NULL' => true";
          } else {
            $properties = "";
          }
          if ($default) {
            if ($properties) {
              $properties .= ", ";
            }
            $properties .= "'DEFAULT' => true";
          }
        } else {
          $properties = "";
        }
        if ($datatype =~ m!VARCHAR\((\d+)\)!) {
          $length = $1;
          push(@fields, "    \$this->field['$fieldname'] = new DT_Varchar( \$this, array($properties), $length );\n");$$
        } elsif ($datatype =~ m!CHAR\((\d+)\)!) {
          $length = $1;
          push(@fields, "    \$this->field['$fieldname'] = new DT_Char( \$this, array($properties), $length );\n");
        } elsif ($datatype =~ m!TEXT!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Text( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!SERIAL!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Serial( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!INTEGER!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Integer( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!BOOL!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Bool( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!TIMESTAMP!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Timestamp( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!DATE!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Date( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!INTERVAL!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Interval( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!TIME!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Time( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!SMALLINT!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Smallint( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!DECIMAL\((\d+), *(\d+)\)!) {
          $precision = $1;
          $scale = $2;
          push(@fields, "    \$this->field['$fieldname'] = new DT_Decimal( \$this, array($properties), $precision, $scale );\n");
        } elsif ($datatype =~ m!BYTEA!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Bytea( \$this, array($properties) );\n");
        } elsif ($datatype =~ m!INET!) {
          push(@fields, "    \$this->field['$fieldname'] = new DT_Inet( \$this, array($properties) );\n");
        } else {
          die "unsupported datatype $tablename:$fieldname : $datatype";
        }
        next;
      }

      if (m!^\); *$! || m!^\) WITHOUT OIDS; *$!) {
        open ( PHPFILE, '+>', $tablename.".php");
        print  PHPFILE "<?php\n\n";
        print  PHPFILE "require_once('entity.php');\n\n";
        print  PHPFILE "/**\n * Class for accessing, manipulating, creating and deleting records in $tablename.\n*/\n\n";
        print  PHPFILE "class $tablename extends DB_Base\n";
        print  PHPFILE "{\n";
        print  PHPFILE "\n  public function __construct(\$select = array())\n";
        print  PHPFILE "  {\n";
        print  PHPFILE "    \$this->table = '$tablename';\n";
        print  PHPFILE "    \$this->order = '';\n";
        print  PHPFILE "    \$this->domain = '$tablename';\n";
        print  PHPFILE $line while ($line = shift(@fields));
        print  PHPFILE $line while ($line = shift(@field_pkey));
        print  PHPFILE "    parent::__construct(\$select);\n";
        print  PHPFILE "  }\n\n";
        print  PHPFILE "}\n\n?>";
        close ( PHPFILE );
        last;
      }
      die "$_ this should not be reached\n";
    }
  }
  next;
}

