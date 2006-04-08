class PentabarfController < ApplicationController
  before_filter :authorize, :check_permission
  after_filter :save_preferences, :except => [:meditation, :activity, :save_conference, :save_event, :save_person]
  after_filter :compress

  def initialize
    @content_title = '@content_title'
    @content_subtitle = ''
  end

  def index
    @content_title = 'Overview'
  end

  def mail
    @content_title = 'Mail'
    @recipients = [['speaker', 'All Speaker'],
                   ['missing_slides', 'Missing Slides']]
  end

  def recipients
    return render_text('') unless params[:id]
    @recipients = case params[:id]
      when 'speaker'  then   Momomoto::View_mail_accepted_speaker.find({:conference_id => @current_conference_id}, nil, 'lower(name)')
      when 'missing_slides'   then   Momomoto::View_mail_missing_slides.find({:conference_id => @current_conference_id}, nil, 'lower(name)')
      else raise 'You have to choose recipients'
    end
    render(:partial=>'recipients')
  end

  def send_mail
    variables = ['name', 'conference_acronym', 'conference_title']
    if params[:mail][:recipients]
      recipients = case params[:mail][:recipients]
        when 'speaker'  then
          Momomoto::View_mail_accepted_speaker.find({:conference_id => @current_conference_id})
        when 'missing_slides' then
          Momomoto::View_mail_missing_slides.find({:conference_id => @current_conference_id})
        else raise 'You have to choose recipients'
      end
      recipients.each_unique(:person_id) do | r |
        events = []
        recipients.each_by_value({:person_id=>r.person_id}) do | recipient |
          events.push( recipient.event_title )
        end
        body = params[:mail][:body].dup
        subject = params[:mail][:subject].dup
        variables.each do | v |
          body.gsub!("{{#{v.upcase}}}", r[v])
          subject.gsub!("{{#{v.upcase}}}", r[v])
        end
        body.gsub!('{{EVENT_TITLE}}', events.join(','))
        subject.gsub!('{{EVENT_TITLE}}', events.join(','))
        Notifier::deliver_general(r.email_contact, subject, body)
      end
    end
    redirect_to(:action=>:mail)
  end

  def schedule
    @content_title = 'Schedule'
    @events = Momomoto::View_schedule.find({:conference_id => @current_conference_id, :translated_id => @current_language_id})
  end

  def find_conference
    @content_title ='Find Conference'
  end

  def review
    @content_title = 'Review'
  end

  def search_conference
    @preferences[:search_conference] = request.raw_post.to_s.gsub(/&.*$/, '') unless params[:id]
    @preferences[:search_conference_type] = 'simple'
    if params[:id] && params[:id] != '-1'
      @preferences[:search_conference_page] = params[:id].to_i
    elsif params[:id].nil?
      @preferences[:search_conference_page] = 0
    end
    @current_page = @preferences[:search_conference_page]
    if @preferences[:search_conference].match(/^ *(\d+ *)+$/)
      @conferences = Momomoto::View_find_conference.find( {:conference_id => @preferences[:search_conference].split(' ')} )
    else
      @conferences = Momomoto::View_find_conference.find( {:search => @preferences[:search_conference].split(' ')} )
    end
    @current_page = 0 if @conferences.length < (@preferences[:hits_per_page] * @current_page)
    render(:partial => 'search_conference')
  end

  def find_event
    @content_title ='Find Event'
  end

  def search_event
    @preferences[:search_event] = request.raw_post.to_s.gsub(/&.*$/, '') unless params[:id]
    @preferences[:search_event_type] = 'simple'
    if params[:id] && params[:id] != '-1'
      @preferences[:search_event_page] = params[:id].to_i
    elsif params[:id].nil?
      @preferences[:search_event_page] = 0
    end
    @current_page = @preferences[:search_event_page]
    if @preferences[:search_event].match(/^ *(\d+ *)+$/)
      @events = Momomoto::View_find_event.find( {:event_id => @preferences[:search_event].split(' '), :conference_id => @current_conference_id, :translated_id => @current_language_id} )
    else
      @events = Momomoto::View_find_event.find( {:s_title => @preferences[:search_event].split(' '), :conference_id => @current_conference_id, :translated_id => @current_language_id} )
    end
    @current_page = 0 if @events.length < (@preferences[:hits_per_page] * @current_page)
    render(:partial => 'search_event')
  end

  def search_event_advanced
    @preferences[:search_event_advanced] = params[:search] if params[:search]
    @preferences[:search_event_type] = 'advanced'
    if params[:id] && params[:id] != '-1'
      @preferences[:search_event_advanced_page] = params[:id].to_i
    elsif params[:id].nil?
      @preferences[:search_event_advanced_page] = 0
    end
    @current_page = @preferences[:search_event_advanced_page]
    conditions = transform_advanced_search_conditions( @preferences[:search_event_advanced] )
    conditions[:translated_id] = @current_language_id
    conditions[:conference_id] = @current_conference_id
    @events = Momomoto::View_find_event.find( conditions )
    @current_page = 0 if @events.length < (@preferences[:hits_per_page] * @current_page)
    render(:partial => 'search_event')
  end

  def save_person_search
    params[:save_person_search][:name].gsub!( /\W/, '' )
    if params[:save_person_search][:name].to_s != ''
      @preferences[:saved_person_search][params[:save_person_search][:name]] = @preferences[:search_person_advanced].dup
    end
    render_text( @preferences[:saved_person_search].keys.collect{|k| "<option value=\"#{k}\">#{k}</option>"}.sort.join )
  end

  def restore_person_search
    @preferences[:search_person_advanced] = @preferences[:saved_person_search][params[:id].to_sym] if @preferences[:saved_person_search][params[:id].to_sym]
    redirect_to( {:action => :find_person} )
  end

  def delete_person_search
    @preferences[:saved_person_search].delete(params[:id].to_sym) if params[:id] && @preferences[:saved_person_search][params[:id].to_sym]
    redirect_to( {:action => :find_person} )
  end

  def save_event_search
    params[:save_event_search][:name].gsub!( /\W/, '' )
    if params[:save_event_search][:name].to_s != ''
      @preferences[:saved_event_search][params[:save_event_search][:name]] = @preferences[:search_event_advanced].dup
    end
    render_text( @preferences[:saved_event_search].keys.collect{|k| "<option value=\"#{k}\">#{k}</option>"}.sort.join )
  end

  def restore_event_search
    @preferences[:search_event_advanced] = @preferences[:saved_event_search][params[:id].to_sym] if @preferences[:saved_event_search][params[:id].to_sym]
    redirect_to( {:action => :find_event} )
  end

  def delete_event_search
    @preferences[:saved_event_search].delete(params[:id].to_sym) if params[:id] && @preferences[:saved_event_search][params[:id].to_sym]
    redirect_to( {:action => :find_event} )
  end

  def search_person_advanced
    @preferences[:search_person_advanced] = params[:search] if params[:search]
    @preferences[:search_person_type] = 'advanced'
    if params[:id] && params[:id] != '-1'
      @preferences[:search_person_advanced_page] = params[:id].to_i
    elsif params[:id].nil?
      @preferences[:search_person_advanced_page] = 0
    end
    @current_page = @preferences[:search_person_advanced_page]
    @persons = Momomoto::View_find_person.find( transform_advanced_search_conditions(@preferences[:search_person_advanced]), nil, nil, :person_id )
    @current_page = 0 if @persons.length < (@preferences[:hits_per_page] * @current_page)
    render(:partial => 'search_person')
  end

  def find_person
    @content_title ='Find Person'
  end

  def search_person
    @preferences[:search_person] = request.raw_post.to_s.gsub(/&.*$/,'') unless params[:id]
    @preferences[:search_person_type] = 'simple'
    if params[:id] && params[:id] != '-1'
      @preferences[:search_person_page] = params[:id].to_i
    elsif params[:id].nil?
      @preferences[:search_person_page] = 0
    end
    @current_page = @preferences[:search_person_page]
    if @preferences[:search_person].match(/^ *(\d+ *)+$/)
      @persons = Momomoto::View_find_person.find( {:person_id => @preferences[:search_person].split(' ')}, nil, nil, :person_id )
    else
      @persons = Momomoto::View_find_person.find( {:search => @preferences[:search_person].split(' ')}, nil, nil, :person_id )
    end
    @current_page = 0 if @persons.length < (@preferences[:hits_per_page] * @current_page)
    render(:partial => 'search_person')
  end

  def recent_changes
    @content_title ='Recent Changes'
    @changes = Momomoto::View_recent_changes.find( {}, params[:id] || 25 )
  end

  def conference
    if params[:id]
      if params[:id] == 'new'
        @content_title ='New Conference'
        @conference = Momomoto::Conference.new_record
        @conference.conference_id = 0
      else
        @conference = Momomoto::Conference.find( {:conference_id => params[:id] } )
        if @conference.length != 1
          redirect_to(:action => :meditation)
          return
        end
        @content_title = @conference.title
      end
    else
      render( :template => 'meditation', :layout => false )
    end
  end

  def copy_event
    raise Momomoto::Permission_Error, 'not allowed to copy event.' unless @user.permission?('create_event')
    new_event = Momomoto::Copy_event.find({:event_id=>params[:id], :conference_id=>params[:conference_id], :person_id=>@user.person_id})
    redirect_to(:action=>:event,:id=>new_event.new_event_id)
  end

  def event
    if params[:id]
      if params[:id] == 'new'
        @content_title ='New Event'
        @event = Momomoto::Event.new_record
        @event.event_id = 0
        @event.conference_id = @current_conference_id
        @rating = Momomoto::Event_rating.new_record
      else
        @event = Momomoto::Event.find( {:event_id => params[:id] } )
        if @event.length != 1
          redirect_to(:action => :meditation)
          return
        end
        @rating = Momomoto::Event_rating.find({:event_id => params[:id], :person_id => @user.person_id})
        @rating.create if @rating.length != 1
        @content_title = @event.title
        @content_subtitle = @event.subtitle
      end
      @conference = Momomoto::Conference.find( {:conference_id => @event.conference_id } )
    else
      redirect_to(:action => :meditation)
    end
  end

  def person
    if params[:id]
      if params[:id] == 'new'
        @content_title ='New Person'
        @person = Momomoto::View_person.new_record
        @person.person_id = 0
        @person.f_spam = true
        @conference_person = Momomoto::Conference_person.new_record
        @conference_person.conference_person_id = 0
        @conference_person.conference_id = @current_conference_id
        @conference_person.person_id = 0
        @person_travel = Momomoto::Person_travel.new_record
        @rating = Momomoto::Person_rating.new_record
      else
        @person = Momomoto::View_person.find( {:person_id => params[:id]} )
        if @person.length != 1
          redirect_to(:action => :meditation)
          return
        end
        @content_title = @person.name
        @conference_person = Momomoto::Conference_person.find({:conference_id => @current_conference_id, :person_id => @person.person_id})
        if @conference_person.length != 1
          @conference_person.create
          @conference_person.conference_person_id = 0
          @conference_person.conference_id = @current_conference_id
          @conference_person.person_id = @person.person_id
        end
        @person_travel = Momomoto::Person_travel.find( {:person_id => params[:id],:conference_id => @current_conference_id} )
        @person_travel.create if @person_travel.length == 0
        @rating = Momomoto::Person_rating.find({:person_id => params[:id], :evaluator_id => @user.person_id})
        @rating.create if @rating.length != 1
      end
    else
      render( :template => 'meditation', :layout => false )
    end
  end

  def conflicts
    @content_title = 'Conflicts'
  end

  def conflicts_event
    if params[:id].to_i > 0
      render(:partial => 'conflicts_event')
    else
      redirect_to(:action=>:meditation)
    end
  end

  def conflicts_person
    if params[:id].to_i > 0
      render(:partial => 'conflicts_person')
    else
      redirect_to(:action=>:meditation)
    end
  end

  def reports
    @content_title ='Reports'

  end

  def report_feedback
    @feedback = Momomoto::View_report_feedback.find({:conference_id => @current_conference_id}, nil, "lower(title), lower(subtitle)")
    render(:partial => 'report_feedback')
  end

  def report_not_arrived
    @arrived = Momomoto::View_report_arrived.find({:conference_id => @current_conference_id, :f_arrived => 'f'})
    render(:partial => 'report_not_arrived')
  end

  def report_arrived
    @arrived = Momomoto::View_report_arrived.find({:conference_id => @current_conference_id, :f_arrived => 't'})
    render(:partial => 'report_arrived')
  end

  def report_expenses
    @expenses = Momomoto::View_report_expenses.find({:conference_id => @current_conference_id, :language_id => @current_language_id})
    render(:partial => 'report_expenses')
  end

  def report_paper
    @paper = Momomoto::View_report_paper.find({:conference_id => @current_conference_id})
    render(:partial => 'report_paper')
  end

  def report_pickup
    @pickup = Momomoto::View_report_pickup.find({:conference_id => @current_conference_id, :language_id => @current_language_id})
    render(:partial => 'report_pickup')
  end

  def report_schedule
    @speaker_male = Momomoto::View_report_schedule_gender.find({:conference_id=>@current_conference_id,:gender=>'t'}).length
    @speaker_female = Momomoto::View_report_schedule_gender.find({:conference_id=>@current_conference_id,:gender=>'f'}).length
    @speaker_unknown = Momomoto::View_report_schedule_gender.find({:conference_id=>@current_conference_id,:gender=>false}).length
    @speaker_total = @speaker_male + @speaker_female + @speaker_unknown
    render(:partial => 'report_schedule')
  end

  def activity
    render(:partial => 'activity')
  end

  def meditation
    render( :template => 'meditation', :layout => false )
  end

  def save_person
    if params[:id] == 'new'
      person = Momomoto::Person.new_record
    else
      person = Momomoto::Person.find( {:person_id => params[:person_id]} )
    end
    if person.length == 1
      if params[:changed_when] != ''
        transaction = Momomoto::Person_transaction.find( {:person_id => person.person_id} )
        if transaction.length == 1 && transaction.changed_when != params[:changed_when]
          render_text('Outdated Data.')
          return
        end
      end

      modified = false
      person.begin

      begin

        params[:person].each do | key, value |
          next if key.to_sym == :preferences || key.to_sym == :password || key.to_sym == :login_name
          person[key]= value
        end
        person[:f_spam] = 'f' unless params[:person]['f_spam']
        person[:login_name] = params[:person][:login_name] if person.permission?('modify_login')
        if person.permission?('modify_login') || person.person_id == @user.person_id
          if params[:person][:password].to_s != ''
            if params[:person][:password] != params[:password]
            @meditation_message = 'Passwords do not match'
            raise "Passwords do not match"
            end
          end
          person.password= params[:person][:password]
          prefs = person.preferences
          prefs[:current_language_id] = params[:person][:preferences][:current_language_id].to_i
          if prefs[:hits_per_page] != params[:person][:preferences][:hits_per_page].to_i
            prefs[:hits_per_page] = params[:person][:preferences][:hits_per_page].to_i
            prefs[:search_conference_page] = 0
            prefs[:search_conference_advanced_page] = 0
            prefs[:search_event_page] = 0
            prefs[:search_event_advanced_page] = 0
            prefs[:search_person_page] = 0
            prefs[:search_person_advanced_page] = 0
          end
          person.preferences = prefs
        end
        modified = true if person.write

        conference_person = Momomoto::Conference_person.new
        modified = true if save_record( conference_person,
                                       {:conference_person_id => params[:conference_person][:conference_person_id],
                                        :person_id => person.person_id,
                                        :conference_id => params[:conference_person][:conference_id] },
                                        params[:conference_person] )

        image = Momomoto::Person_image.new
        image.select({:person_id => person.person_id})
        if image.length != 1 && params[:person_image] && params[:person_image][:image] && params[:person_image][:image].size > 0
          image.create
          image.person_id = person.person_id
        end
        if image.length == 1
          if params[:person_image] && params[:person_image][:delete]
            modified = true if image.delete
          else
            image.f_public = ( params[:person_image] && params[:person_image][:f_public] ) ? true : false
            if params[:person_image] && params[:person_image][:image] && params[:person_image][:image].size > 0
              mime_type = Momomoto::Mime_type.find({:mime_type => params[:person_image][:image].content_type.chomp, :f_image => 't'})
              raise "mime-type not found #{params[:person_image][:image].content_type}" if mime_type.length != 1
              image.mime_type_id = mime_type.mime_type_id
              image.image = process_image( params[:person_image][:image].read )
            end
            modified = true if image.write
          end
        end

        if person.permission?('modify_login')
          person_role = Momomoto::Person_role.new
          for role in Momomoto::Role.find
            if params[:person_role] && params[:person_role][role.role_id.to_s]
              modified = true if save_record( person_role, {:person_id => person.person_id, :role_id => role.role_id}, [])
            else
              modified = true if delete_record( person_role, {:person_id => person.person_id, :role_id => role.role_id})
            end
          end
        end

        modified = true if save_record( Momomoto::Person_travel.new,
                                       {:person_id => person.person_id, :conference_id => @current_conference_id},
                                        params[:person_travel]) do | table |
          table.f_arrived = 'f' unless params[:person_travel]['f_arrived']
          table.f_arrival_pickup = 'f' unless params[:person_travel]['f_arrival_pickup']
          table.f_departure_pickup = 'f' unless params[:person_travel]['f_departure_pickup']
          table.f_need_travel_cost = 'f' unless params[:person_travel]['f_need_travel_cost']
          table.f_need_accommodation_cost = 'f' unless params[:person_travel]['f_need_accommodation_cost']
        end

        if params[:event_person]
          event = Momomoto::Event_person.new
          params[:event_person].each do | key, value |
            if save_or_delete_record( event, {:person_id => person.person_id, :event_person_id => value[:event_person_id]}, value)
              transaction = Momomoto::Event_transaction.new_record
              transaction.event_id = event.event_id
              transaction.changed_by = @user.person_id
              transaction.write
              modified = true
            end
          end
        end

        if params[:person_im]
          person_im = Momomoto::Person_im.new
          params[:person_im].each do | key, value |
            modified = true if save_or_delete_record( person_im, {:person_id => person.person_id, :person_im_id => value[:person_im_id]}, value)
          end
        end

        if params[:person_phone]
          person_phone = Momomoto::Person_phone.new
          params[:person_phone].each do | key, value |
            next if value[:phone_number].to_s == ''
            modified = true if save_or_delete_record( person_phone, {:person_id => person.person_id, :person_phone_id => value[:person_phone_id]}, value)
          end
        end

        if params[:person_language]
          language = Momomoto::Person_language.new
          params[:person_language].each do | key, value |
            modified = true if save_or_delete_record( language, {:person_id => person.person_id, :language_id => value[:language_id]}, value)
          end
        end

        if params[:link]
          person_link = Momomoto::Conference_person_link.new
          params[:link].each do | key, value |
            next if value[:url].to_s == ''
            modified = true if save_or_delete_record( person_link, {:conference_person_id => conference_person.conference_person_id, :conference_person_link_id => value[:link_id]}, value)
          end
        end

        if params[:internal_link]
          person_link_internal = Momomoto::Conference_person_link_internal.new
          params[:internal_link].each do | key, value |
            next if value[:url].to_s == ''
            modified = true if save_or_delete_record( person_link_internal, {:conference_person_id => conference_person.conference_person_id, :conference_person_link_internal_id => value[:internal_link_id]}, value)
          end
        end

        if modified == true
          transaction = Momomoto::Person_transaction.new_record
          transaction.person_id = person.person_id
          transaction.changed_by = @user.person_id
          transaction.f_create = true if params[:id] == 'new'
          transaction.write
          person.commit
        else
          person.rollback
        end
      rescue => e
        person.rollback
        @meditation_message = "You are not allowed to do this." if e.class == Momomoto::Permission_Error
        raise e
      end
      save_record( Momomoto::Person_rating.new, {:person_id => person.person_id, :evaluator_id => @user.person_id},
                   params[:rating]) do | table |
        table.eval_time = 'now()' if table.dirty?
      end

      redirect_to({:action => :person, :id => person.person_id})
    else
      redirect_to({:action => :person, :id => params[:id]})
    end
  end

  def save_conference
    if params[:id] == 'new'
      conference = Momomoto::Conference.new_record
    else
      conference = Momomoto::Conference.find( {:conference_id => params[:conference_id]})
    end
    if conference.length == 1
      if params[:changed_when] != ''
        transaction = Momomoto::Conference_transaction.find( {:conference_id => conference.conference_id} )
        if transaction.length == 1 && transaction.changed_when != params[:changed_when]
          render_text('Outdated Data.')
          return
        end
      end

      modified = false
      conference.begin

      begin
        params[:conference].each do | key, value |
          conference[key]= value
        end
        conference.f_feedback_enabled = 'f' unless params[:conference]['f_feedback_enabled']
        conference.f_submission_enabled = 'f' unless params[:conference]['f_submission_enabled']
        conference.f_visitor_enabled = 'f' unless params[:conference]['f_visitor_enabled']
        modified = true if conference.write

        image = Momomoto::Conference_image.new
        image.select({:conference_id => conference.conference_id})
        if image.length != 1 && params[:conference_image] && params[:conference_image][:image] && params[:conference_image][:image].size > 0
          image.create
          image.conference_id = conference.conference_id
        end
        if image.length == 1
          if params[:conference_image][:delete]
            modified = true if image.delete
          else
            if params[:conference_image][:image].size > 0
              mime_type = Momomoto::Mime_type.find({:mime_type => params[:conference_image][:image].content_type.chomp, :f_image => 't'})
              raise "mime-type not found #{params[:conference_image][:image].content_type}" if mime_type.length != 1
              image.mime_type_id = mime_type.mime_type_id
              image.image = process_image( params[:conference_image][:image].read )
            end
            modified = true if image.write
          end
        end

        if params[:team]
          team = Momomoto::Team.new
          params[:team].each do | key, value |
            modified = true if save_or_delete_record( team, {:conference_id => conference.conference_id, :team_id => value[:team_id]}, value)
          end
        end

        if params[:conference_track]
          track = Momomoto::Conference_track.new
          params[:conference_track].each do | key, value |
            next if value[:tag].to_s == ''
            modified = true if save_or_delete_record( track, {:conference_id => conference.conference_id, :conference_track_id => value[:conference_track_id]}, value)
          end
        end

        if params[:room]
          room = Momomoto::Room.new
          params[:room].each do | key, value |
            modified = true if save_or_delete_record( room, {:conference_id => conference.conference_id, :room_id => value[:room_id]}, value) { | t |
              t.f_public = false unless value[:f_public]
            }
          end
        end

        if params[:conference_language]
          language = Momomoto::Conference_language.new
          params[:conference_language].each do | key, value |
            modified = true if save_or_delete_record( language, {:conference_id => conference.conference_id, :language_id => value[:language_id]}, value)
          end
        end

        if modified == true
          transaction = Momomoto::Conference_transaction.new_record
          transaction.conference_id = conference.conference_id
          transaction.changed_by = @user.person_id
          transaction.f_create = true if params[:id] == 'new'
          transaction.write
          conference.commit
        else
          conference.rollback
        end
      rescue => e
        conference.rollback
        @meditation_message = "You are not allowed to do this." if e.class == Momomoto::Permission_Error
        raise e
      end
      redirect_to({:action => :conference, :id => conference.conference_id})
    else
      redirect_to({:action => :conference, :id => params[:id]})
    end
  end

  def save_event
    if params[:id] == 'new'
      event = Momomoto::Event.new_record
    else
      event = Momomoto::Event.find( {:event_id => params[:event_id]} )
    end
    if event.length == 1
      if params[:changed_when] != ''
        transaction = Momomoto::Event_transaction.find( {:event_id => event.event_id} )
        if transaction.length == 1 && transaction.changed_when != params[:changed_when]
          render_text('Outdated Data.')
          return
        end
      end

      modified = false
      event.begin

      begin
        params[:event].each do | key, value |
          next if key == :conference_id
          event[key]= value
        end
        event.conference_id = params[:event][:conference_id] if @user.permission?( 'move_event' )
        event.conference_id = @current_conference_id unless event.conference_id
        event.f_public = 'f' unless params[:event]['f_public']
        event.f_paper = 'f' unless params[:event]['f_paper']
        event.f_slides = 'f' unless params[:event]['f_slides']
        modified = true if event.write

        if params[:related_event]
          params[:related_event].each do | key, value |
            modified = true if save_or_delete_record(Momomoto::Event_related.new, {:event_id1 => event.event_id, :event_id2 => value[:related_event_id]}, value)
          end
        end

        image = Momomoto::Event_image.new
        image.select({:event_id => event.event_id})
        if image.length != 1 && params[:event_image] && params[:event_image][:image] && params[:event_image][:image].size > 0
          image.create
          image.event_id = event.event_id
        end
        if image.length == 1
          if params[:event_image] && params[:event_image][:delete]
            modified = true if image.delete
          elsif params[:event_image] && params[:event_image][:image] && params[:event_image][:image].size > 0
            mime_type = Momomoto::Mime_type.find({:mime_type => params[:event_image][:image].content_type.chomp, :f_image => 't'})
            raise "mime-type not found #{params[:event_image][:image].content_type}" if mime_type.length != 1
            image.mime_type_id = mime_type.mime_type_id
            image.image = process_image( params[:event_image][:image].read )
            modified = true if image.write
          end
        end

        if params[:attachment_upload]
          file = Momomoto::Event_attachment.new
          params[:attachment_upload].each do | key, value |
            next unless value[:data].size > 0
            file.create
            file.event_id = event.event_id
            file.attachment_type_id = value[:attachment_type_id]
            mime_type = Momomoto::Mime_type.find({:mime_type => value[:data].content_type.chomp})
            raise "mime-type not found #{value[:data].content_type}" if mime_type.length != 1
            file.mime_type_id = mime_type.mime_type_id
            file.filename = value[:filename].to_s != '' ? value[:filename] : File.basename(value[:data].original_filename).gsub(/[^\w0-9.-_]/, '')
            file.title = value[:title]
            file.data = value[:data].read
            file.f_public = value[:f_public] ? true : false
            modified = true if file.write
          end
        end

        if params[:event_attachment]
          attachment = Momomoto::Event_attachment.new
          params[:event_attachment].each do | key, value |
            modified = true if save_or_delete_record( attachment, {:event_attachment_id => key, :event_id => event.event_id}, value ) { | t |
              t.f_public = value[:f_public] ? true : false
            }
          end
        end

        if params[:event_person]
          person = Momomoto::Event_person.new
          params[:event_person].each do | key, value |
            if save_or_delete_record( person, {:event_id => event.event_id, :event_person_id => value[:event_person_id]}, value )
              transaction = Momomoto::Person_transaction.new_record
              transaction.person_id = person.person_id
              transaction.changed_by = @user.person_id
              transaction.write
              modified = true
            end
          end
        end

        if params[:link]
          event_link = Momomoto::Event_link.new
          params[:link].each do | key, value |
            next if value[:url].to_s == ''
            modified = true if save_or_delete_record( event_link, {:event_id => event.event_id, :event_link_id => value[:link_id]}, value)
          end
        end

        if params[:internal_link]
          event_link_internal = Momomoto::Event_link_internal.new
          params[:internal_link].each do | key, value |
            next if value[:url].to_s == ''
            modified = true if save_or_delete_record( event_link_internal, {:event_id => event.event_id, :event_link_internal_id => value[:internal_link_id]}, value)
          end
        end

        if modified == true
          transaction = Momomoto::Event_transaction.new_record
          transaction.event_id = event.event_id
          transaction.changed_by = @user.person_id
          transaction.f_create = true if params[:id] == 'new'
          transaction.write
          event.commit
        else
          event.rollback
        end
      rescue => e
        event.rollback
        @meditation_message = "You are not allowed to do this." if e.class == Momomoto::Permission_Error
        raise e
      end

      save_record(Momomoto::Event_rating.new, {:person_id => @user.person_id, :event_id => event.event_id}, params[:rating]) do | t |
        t.eval_time = 'now()' if t.dirty?
      end

      redirect_to({:action => :event, :id => event.event_id})
    else
      redirect_to({:action => :event, :id => params[:id]})
    end
  end

  protected

  # transforms request from advanced search into a form understandable by momomoto
  def transform_advanced_search_conditions( search )
    search = search.dup
    conditions = {}
    search.each do | row_number, value |
      next if value[:type].nil?
      type  = value[:type].to_sym
      logic = case value[:logic]
                          when 'is','contains' then :eq
                          when 'is not', "does not contain" then :ne
                          else :eq
                        end
      conditions[type] = {} unless conditions[type]
      conditions[type][logic] = Array.new unless conditions[type][logic]
      conditions[type][logic].push( value[:value].dup)
    end
    conditions
  end

  def check_permission
    #redirect_to :action => :meditation if params[:action] != 'meditation'
    if @user.permission?('pentabarf_login') || params[:action] == 'meditation'
      @preferences = @user.preferences.dup
      if params[:current_conference_id]
        conf = Momomoto::Conference.find({:conference_id => params[:current_conference_id]})
        if conf.length == 1
          @preferences[:current_conference_id] = params[:current_conference_id].to_i
          @user.preferences = @preferences
          @user.write
          redirect_to
          return false
        end
      end
      @current_conference_id = @preferences[:current_conference_id]
      @current_language_id = @preferences[:current_language_id]
      return true
    end
    redirect_to( :action => :meditation )
    false
  end

  def process_image( image )
    image
  end

end
