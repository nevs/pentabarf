class SubmissionController < ApplicationController

  before_filter :init
  after_filter :set_content_type

  def index
  end

  def person
    @person = POPE.user
    @conference_person = Conference_person.select_or_new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @person_travel = Person_travel.select_or_new({:conference_id=>@conference.conference_id, :person_id=>@person.person_id})
    @person_image = Person_image.select_or_new({:person_id=>@person.person_id})
    @transaction = Person_transaction.select_single({:person_id=>@person.person_id}) rescue Person_transaction.new
  end

  def save_person
    Momomoto::Database.instance.transaction do
      params[:person][:person_id] = POPE.user.person_id
      person = write_row( Person, params[:person], {:except=>[:person_id,:password,:password2],:always=>[:f_spam]} ) do | row |
        if params[:person][:password].to_s != ""
          raise "Passwords do not match" if params[:person][:password] != params[:person][:password2]
          row.password = params[:person][:password]
        end
      end
      conference_person = write_row( Conference_person, params[:conference_person], {:preset=>{:person_id => person.person_id,:conference_id=>@conference.conference_id}})
      write_row( Person_travel, params[:person_travel], {:preset=>{:person_id => person.person_id,:conference_id=>@conference.conference_id}})
      write_rows( Person_language, params[:person_language], {:preset=>{:person_id => person.person_id}})
      write_rows( Conference_person_link, params[:conference_person_link], {:preset=>{:conference_person_id => conference_person.conference_person_id}})
      write_rows( Person_im, params[:person_im], {:preset=>{:person_id => person.person_id}})
      write_rows( Person_phone, params[:person_phone], {:preset=>{:person_id => person.person_id}})

      write_file_row( Person_image, params[:person_image], {:preset=>{:person_id => person.person_id},:always=>[:f_public],:image=>true})
      write_person_availability( @conference, person, params[:person_availability])

      Person_transaction.new({:person_id=>person.person_id,:changed_by=>POPE.user.person_id}).write

      redirect_to( :action => :person )
    end
  end

  protected

  def init
    @conferences = Conference.select({:f_submission_enabled=>'t'})
    @conference = Conference.select_single(:acronym=>params[:conference]) rescue nil
    # FIXME: remove hardcoded language
    @current_language_id = 120
  end

  def check_permission
    return params[:action] || POPE.permission?('submission_login')
  end

  def set_content_type
    # FIXME: jscalendar does not work with application/xml
    response.headers['Content-Type'] = 'text/html'
  end

end
