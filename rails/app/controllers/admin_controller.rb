class AdminController < ApplicationController

  before_filter :init

  def index
    @content_title = 'Admin'
  end

  def account_roles
    @account = Account.select_single(:account_id=>params[:id])
    @account_roles = Account_role.select(:account_id=>@account.account_id)
  end

  def save_account_roles
    account = Account.select_single(:account_id=>params[:id])

    params[:account_role].each do | k,v | v[:remove] = true if not v[:set] end
    write_rows( Account_role, params[:account_role], {:preset=>{:account_id=>account.account_id},:except=>[:set]})

    params[:account_conference_role].each do | conference_id, conf_v |
      conf_v.each do | k,v | v[:remove] = true if not v[:set] end
      write_rows( Account_conference_role, conf_v, {:preset=>{:account_id=>account.account_id,:conference_id=>conference_id},:except=>[:set]})
    end

    redirect_to(:action=>:account_roles,:id=>account.account_id)
  end

  def conflict_setup
    @content_title = 'Conflict Setup'
    @phases = Conference_phase_localized.select(:translated=>@current_language)
    @conflicts = Conflict_localized.select({:translated=>@current_language})
    @level = Conflict_level_localized.select(:translated=>@current_language).map{|l|[l.conflict_level,l.name]}
    @phase_conflicts = Conference_phase_conflict.select
  end

  def role_permissions
    @roles = Role.select
  end

  def conference_role_permissions
  end

  def save_new_role
    Role.new({:role=>params[:role]}).write
    redirect_to(:action=>:role_permissions)
  end

  def save_new_conference_role
    Conference_role.new({:conference_role=>params[:conference_role]}).write
    redirect_to(:action=>:conference_role_permissions)
  end

  def save_role_permissions
    permissions = Permission.select.map(&:permission)
    params[:role_permission].each do | role, values |
      rp = Role_permission.select({:role=>role}).map(&:permission)
      permissions.each do | perm |
        if rp.member?( perm ) && !values[perm]
          # permission has to be removed
          Role_permission.select_single({:role=>role,:permission=>perm}).delete
        elsif !rp.member?( perm ) && values[perm]
          # permission has to be set
          Role_permission.new({:role=>role,:permission=>perm}).write
        end
      end
    end
    redirect_to(:action=>:role_permissions)
  end

  def save_conference_role_permissions
    permissions = Permission.select(:conference_permission=>'t').map(&:permission)
    params[:conference_role_permission].each do | conference_role, values |
      rp = Conference_role_permission.select({:conference_role=>conference_role}).map(&:permission)
      permissions.each do | perm |
        if rp.member?( perm ) && !values[perm]
          # permission has to be removed
          Conference_role_permission.select_single({:conference_role=>conference_role,:permission=>perm}).delete
        elsif !rp.member?( perm ) && values[perm]
          # permission has to be set
          Conference_role_permission.new({:conference_role=>conference_role,:permission=>perm}).write
        end
      end
    end
    redirect_to(:action=>:conference_role_permissions)
  end

  def save_conflict_setup
    params[:conflict].each do | conflict, outer |
      outer.each do | conference_phase, value |
        write_row( Conference_phase_conflict, value, {:preset=>{:conflict=>conflict,:conference_phase=>conference_phase}})
      end
    end
    redirect_to( :action => :conflict_setup )
  end

  def custom_fields
    @content_title = 'Custom fields'
    @custom_fields = Custom_fields.select({},{:order=>[:table_name,:field_name]})
  end

  def save_custom_fields
    write_rows( Custom_fields, params[:custom_fields], {:ignore_empty=>:field_name,:always=>[:submission_visible,:submission_settable]})
    redirect_to( :action => :custom_fields )
  end

  protected

  def init
    @current_conference = Conference.select_single(:conference_id => POPE.user.current_conference_id)
    @current_language = POPE.user.current_language
  end

  def check_permission
    raise StandardError if not POPE.permission?('admin::login')
    case params[:action]
      when 'account_roles','save_account_roles' then
        POPE.permission?('account::show')
      else
        # FIXME
        true
    end
  end

end
