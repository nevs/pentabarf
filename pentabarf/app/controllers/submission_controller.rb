class SubmissionController < ApplicationController
  before_filter :check_conference, :except => [:new_account, :create_account, :activate_account, :logout, :login]
  before_filter :authorize, :except => [:index, :create_account, :new_account, :activate_account, :logout]
  before_filter :check_permission, :except => [:index, :create_account, :new_account, :activate_account, :logout]
  before_filter :transparent_authorize
  after_filter :compress

  def index
    @content_title = 'Submission'
    Momomoto::Base.ui_language_id = 120;
  end

  def login
    redirect_to({:action=>:index})
  end

  def new_account
    @content_title = 'Create account'
    
  end

  def create_account
    raise "Passwords do not match" if params[:person][:password] != params[:password]
    person = Momomoto::View_account.new_record
    [:login_name, :password, :email_contact].each do | field |
      raise "Field #{field} is mandatory!" if params[:person][field].to_s.empty?
      person[field]= params[:person][field]
    end
    raise "Invalid email address" unless person.email_contact.match(/[\w.+-]+@([\w]+\.)+\w{2,3}$/)
    #person.write
    account = Momomoto::Account_activation.new_record
    account.activation_string = random_string

    Notifier::deliver_activate_account( person.login_name, person.email_contact, url_for({:action=>:activate_account,:id=>account.activation_string}) )
    render_text("account created") 
  end

  def activate_account
    account = Momomoto::Account_activation.find({:activation_string=>params[:id]})
    raise "Unknown activation sequence." unless account.length == 1
    redirect_to({:action=>:login}) 
  end

  def person

  end

  def event
    #Notifier::deliver_signup_thanks(@user.login_name, @user.email_contact)
    @event = Momomoto::Event.new_record

  end

  protected

  def check_conference
    return true if params[:conference].nil? && params[:action].to_sym == :index
    @conference = Momomoto::Conference.new
    if params[:conference].to_s.match(/^\d+$/)
      @conference.select({:conference_id => params[:conference], :f_submission_enabled => 't'})
    else
      @conference.select({:acronym => params[:conference], :f_submission_enabled => 't'})
    end
    return @conference.length == 1 ? true : redirect_to({:action=>:index,:conference=>nil})
  end

  def check_permission
    return @user.permission?('submission_login')
  end

  # authorize users transparently if login_name and password are sent
  def transparent_authorize()
    login_name, password = get_auth_data
    @user = nil

    if !login_name.empty? && !password.empty?
      @user = Momomoto::Login.authorize( login_name, password )
      @user = nil if @user.nil?
    end 
    if @user
      Momomoto::Base.ui_language_id = @user.preferences[:current_language_id]
    else
      Momomoto::Base.ui_language_id = 120
    end
    @current_language_id = Momomoto::Base.ui_language_id
    return true
  end

  def random_string
    sprintf("%064X", rand(2**256))
  end

end
