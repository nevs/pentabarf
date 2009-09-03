class PentabarfController < ApplicationController

  around_filter :check_current_conference
  before_filter :init
  around_filter :update_last_login, :except=>[:activity]

  def conflicts
    @content_title = "Conflicts"
    @conflict_level = ['fatal','error','warning','note']
    conflicts = []
    conflicts += View_conflict_person.call({:conference_id => @current_conference.conference_id},{ :translated => @current_language})
    conflicts += View_conflict_event.call({:conference_id => @current_conference.conference_id},{ :translated => @current_language})
    conflicts += View_conflict_event_event.call({:conference_id => @current_conference.conference_id},{ :translated => @current_language})
    conflicts += View_conflict_event_person.call({:conference_id => @current_conference.conference_id},{ :translated => @current_language})
    conflicts += View_conflict_event_person_event.call({:conference_id => @current_conference.conference_id},{ :translated => @current_language})
    @conflicts = Hash.new do | k, v | k[v] = Array.new end
    conflicts.each do | c |
      next if not @conflict_level.member?( c.conflict_level )
      @conflicts[c.conflict_level] << c
    end
  end

  def index
    @content_title = "Overview"
  end

  def activity
    @last_active = View_last_active.select( {:login_name => {:ne => POPE.user.login_name}}, {:limit => 12} )
    render(:partial=>'activity')
  end

  def recent_changes
    @content_title = "Recent Changes"
    @changes = View_recent_changes.select( {}, {:limit => params[:id] || 25 } )
  end

  def schedule
    @content_title = 'Schedule'
    @events = View_schedule.select({:conference_id => @current_conference.conference_id, :translated => @current_language})
  end

  def mail
    @content_title = 'Mail'
    @recipients = [['speaker', 'All accepted speakers of this conference'],
                   ['find_person_advanced', 'Resultset from advanced person search'],
                   ['reviewer', 'All persons with the role reviewer'],
                   ['missing_slides', 'Missing Slides'],
                   ['all_speaker', 'All speakers of all conferences']]
  end

  def recipients
    return render_text('') unless params[:id]
    person_ids = []
    @recipients = []
    recipient_members( params[:id], params[:mail][:ignore_spam_flag] == 'on' ).each do | r |
      if not person_ids.member?( r.person_id )
        person_ids << r.person_id
        @recipients << r
      end
    end
    render(:partial=>'recipients')
  end

  def send_mail
    raise Pope::PermissionError, 'not allowed to send mail.' unless POPE.permission?( 'admin::login' )
    from = @current_conference.email 
    variables = ['email','name','person_id','conference_acronym','conference_title']
    if params[:mail][:recipients]
      recipients = recipient_members( params[:mail][:recipients], params[:mail][:ignore_spam_flag] == 'on' )
      person_ids = recipients.map(&:person_id).uniq
      person_ids.each do | person_id |
        begin
          events = recipients.select{|recipient| recipient.person_id == person_id}
          r = events[0]
          titles = []
          events.each do | event |
            titles.push( event.event_title )
          end if r.respond_to?(:event_title)
          body = params[:mail][:body].dup
          subject = params[:mail][:subject].dup
          variables.each do | v |
            body.gsub!(/\{\{#{v}\}\}/i, r[v].to_s)
            subject.gsub!(/\{\{#{v}\}\}/i, r[v].to_s)
          end
          body.gsub!(/\{\{event_title\}\}/i, titles.join(','))
          subject.gsub!(/\{\{event_title\}\}/i, titles.join(','))
          Notifier::deliver_general(r.email, subject, body, from)
        rescue => e
          raise StandardError, "Error while sending mail to #{r.name}<#{r.email}>.: #{e}"
        end
      end
    end
    redirect_to(:action=>:mail)
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @preferences = POPE.user.preferences
    @current_language = POPE.user.current_language || 'en'
  end

  def check_permission
    return true if POPE.conference_permission?('pentabarf::login', POPE.user.current_conference_id)
    if !POPE.conferences_with_permission('pentabarf::login').empty?
      redirect_to(:controller=>'conference',:action=>:select)
    else
      redirect_to(:controller=>'submission')
    end
       
    false
  end

  # converts values submitted by advanced search to a hash understood by momomoto
  def form_to_condition( params, klass )
    conditions = {}
    params.each do | key, value |
      field = value[:key].to_sym
      conditions[field] ||= {}
      value[:type] ||= klass.columns[field].to_s.split('::').last.downcase
      if value[:value] == "" && value[:type] != 'text'
        conditions[field][:eq] ||= []
        conditions[field][:eq] << :NULL
      elsif value[:type] == 'text'
        conditions[field][:ilike] ||= []
        conditions[field][:ilike] << "%#{value[:value]}%"
      else
        conditions[field][:eq] ||= []
        conditions[field][:eq] << value[:value]
      end
    end
    conditions
  end

  def recipient_members( name, ignore_spam_flag = false )
    constraints = {}
    constraints[:spam] = true if not ignore_spam_flag
    case name
      when 'all_speaker' then View_mail_all_speaker.select(constraints,{:order=>Momomoto.lower(:name)})
      when 'find_person_advanced' then View_find_person.select( form_to_condition( POPE.user.preferences[:search_person_advanced], View_find_person), {:distinct=>[:name,:person_id]})
      when 'reviewer' then View_mail_all_reviewer.select(constraints,{:order=>Momomoto.lower(:name)})
      when 'speaker' then View_mail_accepted_speaker.select(constraints.merge({:conference_id => @current_conference.conference_id}),{:order=>Momomoto.lower(:name)})
      when 'missing_slides' then View_mail_missing_slides.select(constraints.merge({:conference_id => @current_conference.conference_id}),{:order=>Momomoto.lower(:name)})
      else raise 'Unknown recipient tag'
    end
  end

end

