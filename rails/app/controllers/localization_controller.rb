class LocalizationController < ApplicationController

  before_filter :init

  def index
    @content_title = 'Localization'
  end

  Localization_tables = [:attachment_type,:conference_phase,:country,:currency,:event_origin,:event_role,:event_role_state,:event_state,:event_state_progress,:event_type,:im_type,:language,:link_type,:mime_type,:phone_type,:transport,:ui_message]

  Localization_tables.each do | category |
    define_method(category) do
      @table = category
      @content_title = "Localization #{category}"
      order = category.to_s.capitalize.constantize.columns.key?(:rank) ? :rank : category
      constraints = {}
      constraints[category] = {:ilike=>"#{params[:id]}%"} if params[:id]
      @tags = category.to_s.capitalize.constantize.select(constraints,{:order=>order})
      constraints = {:translated=>@languages.map(&:language)}
      constraints[category] = {:ilike=>"#{params[:id]}%"} if params[:id]
      @messages = "#{category}_localized".capitalize.constantize.select(constraints,{:order=>category})
      render(:partial=>'localization_form',:layout=>true)
    end

    define_method("save_#{category}") do
      params[category].each do | category_value, value |
        value.each do | translated, value |
          write_row( "#{category}_localized".capitalize.constantize, value, {:only=>[:name],:preset=>{category=>category_value,:translated=>translated},:ignore_empty=>:name})
        end
      end
      redirect_to( :action => category, :id => params[:id] )
    end

  end

  [:event_role_state,:event_state_progress].each do | category |
    define_method(category) do
      @slave = @table = category
      @master = (category.to_s.capitalize.constantize.columns.keys - [@slave,:rank])[0]
      @content_title = "Localization #{category}"
      order = [@master,:rank,@slave]
      constraints = {}
      constraints[category] = {:ilike=>"#{params[:id]}%"} if params[:id]
      @tags = category.to_s.capitalize.constantize.select(constraints,{:order=>order})
      constraints = {:translated=>@languages.map(&:language)}
      constraints[category] = {:ilike=>"#{params[:id]}%"} if params[:id]
      @messages = "#{category}_localized".capitalize.constantize.select(constraints,{:order=>category})
      render(:partial=>'localization_form2',:layout=>true)
    end

    define_method("save_#{category}") do
      slave = category
      master = (category.to_s.capitalize.constantize.columns.keys - [slave,:rank])[0]
      params[category].each do | master_value, value |
        value.each do | slave_value, value |
          value.each do | translated, value |
            write_row( "#{category}_localized".capitalize.constantize, value, {:only=>[:name],:preset=>{master=>master_value,slave=>slave_value,:translated=>translated},:ignore_empty=>:name})
          end
        end
      end
      redirect_to( :action => category, :id => params[:id] )
    end
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
    @languages = Language.select({:localized=>'t'},{:order=>:language})
  end

end
