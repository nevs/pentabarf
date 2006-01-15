module Momomoto
  class View_find_person < Base
    def initialize
      super
      @domain = 'person'
      @order = 'lower(name)'
      @allow_empty = true
      @fields = {
        :search => Datatype::Textsearch.new( {:virtual=>true,:field=>[:first_name, :last_name, :nickname, :login_name, :public_name, :email_contact]} ),
        :s_name => Datatype::Textsearch.new( {:virtual=>true,:field=>[:first_name, :last_name, :nickname, :login_name, :public_name]} ),
        :s_first_name => Datatype::Textsearch.new( {:virtual=>true,:field=>[:first_name]} ),
        :s_last_name => Datatype::Textsearch.new( {:virtual=>true,:field=>[:last_name]} ),
        :s_nickname => Datatype::Textsearch.new( {:virtual=>true,:field=>[:nickname]} ),
        :s_email => Datatype::Textsearch.new( {:virtual=>true,:field=>[:email_contact]} ),
        :s_gender => Datatype::Boolsearch.new( {:virtual=>true,:field=>:gender} ),
        :person_id => Datatype::Integer.new( {} ),
        :name => Datatype::Varchar.new( {} ),
        :first_name => Datatype::Varchar.new( {:length=>64} ),
        :last_name => Datatype::Varchar.new( {:length=>64} ),
        :nickname => Datatype::Varchar.new( {:length=>64} ),
        :public_name => Datatype::Varchar.new( {:length=>64} ),
        :login_name => Datatype::Varchar.new( {:length=>32} ),
        :email_contact => Datatype::Varchar.new( {:length=>64} ),
        :mime_type_id => Datatype::Integer.new( {} ),
        :mime_type => Datatype::Varchar.new( {:length=>128} ),
        :file_extension => Datatype::Varchar.new( {:length=>16} ),
        :conference_id => Datatype::Integer.new( {} )
      }
    end
  end
end
