
require 'icalendar'

module Icalendar

  class Component

    # overwrite print_properties to separate ical line folding
    def print_properties
      s = ""

      @properties.each do |key,val| 
        # Take out underscore for property names that conflicted
        # with built-in words.
        if key =~ /ip_.*/
          key = key[3..-1]
        end

        # Property name
        unless multiline_property?(key)
           prelude = "#{key.gsub(/_/, '-').upcase}" + 

           # Possible parameters
           print_parameters(val) 

           # Property value
           value = ":#{val.to_ical}" 
           escaped = prelude + value.gsub("\\", "\\\\").gsub("\n", "\\n").gsub(",", "\\,").gsub(";", "\\;")
           s << fold_line( escaped )
           s.gsub!(/ *$/, '')
         else
           prelude = "#{key.gsub(/_/, '-').upcase}" 
            val.each do |v| 
               params = print_parameters(v)
               value = ":#{v.to_ical}"
               escaped = prelude + params + value.gsub("\\", "\\\\").gsub("\n", "\\n").gsub(",", "\\,").gsub(";", "\\;")
               s << fold_line( escaped )
               s.gsub!(/ *$/, '')
            end
         end
      end
      s
    end

    # fix line folding to no longer produce broken utf-8 (this is rails specific)
    def fold_line( line )
      s = ""
      line = line.chars
      s << line.slice!(0, MAX_LINE_LENGTH) << "\r\n " while line.size > MAX_LINE_LENGTH
      s << line << "\r\n"
      s
    end

  end

end

