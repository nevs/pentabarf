# Methods added to this helper will be available to all templates in the application.

require 'builder_helper'

module ApplicationHelper
  include Builder_helper 

  def pentabarf_version
    "0.3.0"
  end

  # tries to read the current revision of pentabarf from subversion meta data
  def pentabarf_revision
    if not self.class.class_variables.member?( '@@revision' )
      revision_file = File.join( RAILS_ROOT, '..', '.svn', 'entries' )
      begin
        content = File.open( revision_file, 'r').read
        if content[0..1] == '<?'    # new svn xml file
          d = REXML::Document.new( content )
          rev = d.elements['//entry[@name=""]/@revision'].to_s
        else                        # simple txt file
          rev = content.split("\n")[3]
        end
        rev = rev.to_i
      rescue
        rev = 0
      end
      @@revision = rev == 0 ? 2342 : rev
    end
    @@revision.to_s
  end

  def local( tag )
    tag
  end

  def js( text )
    text.to_s.gsub(/[<>]/, '').gsub( '\\', '\0\0' ).gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/, '\\\\\0')
  end

  def js_function( name, *parameter )
    parameter.map! do | p | "'#{js(p.to_s)}'" end
    "#{name}(#{parameter.join(',')});"
  end 

  def js_tabs( tabs )
    xml = Builder::XmlMarkup.new
    xml.div( :id => 'tabs' ) do
      tabs.each do | tab |
        xml.span( tab.to_s, {:id=>"tab-#{tab}",:onclick=>"switch_tab('#{tab}')",:class=>'tab inactive'} )
      end
    end
  end


end
