module Momomoto
  class View_recent_changes < Base
    def initialize
      super
      @domain = 'recent_changes'
      @fields = {
        :type => Datatype::Text.new( {} ),
        :id => Datatype::Integer.new( {} ),
        :acronym => Datatype::Varchar.new( {} ),
        :title => Datatype::Varchar.new( {} ),
        :changed_when => Datatype::Timestamp.new( {:with_timezone=>true} ),
        :changed_by => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :f_create => Datatype::Bool.new( {} )
      }
    end
  end
end
