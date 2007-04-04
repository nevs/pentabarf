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


end
