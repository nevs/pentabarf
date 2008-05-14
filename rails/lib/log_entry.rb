
class LogEntry

  RenderMatrix = Hash.new{ :render_default }

  RenderMatrix[ ['account','account_activation'].sort ] = :render_new_account
  RenderMatrix[ ['account','account_activation','account_role','person'].sort ] = :render_account_activated
  RenderMatrix[ ['account','account_password_reset'].sort ] = :render_password_reset
  RenderMatrix[ ['account_password_reset'].sort ] = :render_password_reset_requested

  attr_reader :changes, :log_transaction_id, :log_timestamp, :log_person_id, :log_name, :involved_tables

  def initialize( changeset, controller )
    @log_transaction_id = changeset.log_transaction_id
    @log_timestamp = changeset.log_timestamp
    @log_person_id = changeset.person_id
    @log_name = changeset.name
    @controller = controller
    @involved_tables = Log_transaction_involved_tables.select({:log_transaction_id => log_transaction_id}).map(&:table_name)
    @changes = {}
    involved_tables.each do | table_name |
      @changes[ table_name.to_sym ] = log_class(table_name).select(:log_transaction_id=>log_transaction_id)
    end
  end

  def render_account_activated( xml )
    if check_table_changes( :account, :U ) && check_table_changes( :account_activation, :D ) &&
       check_table_changes( :account_role, :I ) && check_table_changes( :person, :I )
      xml.li do
        xml.a( "User '#{changes[:account][0].login_name}' has activated the account.", {:href=>url_for({:controller=>'pentabarf',:action=>:person,:id=>changes[:account][0].person_id})} )
      end
    else
      render_default( xml )
    end
  end

  def render_password_reset_requested( xml )
    if check_table_changes( :account_password_reset, :I )
      account = Account.select_single({:account_id=>changes[:account_password_reset][0].account_id}).login_name rescue ""
      xml.li "User '#{account}' requested a password reset."
    else
      render_default( xml )
    end
  end

  def render_password_reset( xml )
    if check_table_changes( :account, :U ) && changes[:account_password_reset].map(&:log_operation).uniq == [ :D ]
      xml.li "The password for user '#{changes[:account][0].login_name}' has been reset."
    else
      render_default( xml )
    end
  end

  def render_new_account( xml )
    if check_table_changes( :account, :I ) && check_table_changes( :account_activation, :I )
      xml.li "User '#{changes[:account][0].login_name}' created an account."
    else
      render_default( xml )
    end
  end

  def append( xml )
    xml.li do
      xml.span( log_timestamp.strftime("%Y-%m-%d %H:%M:%S"),{:onclick=>"$('changeset-#{log_transaction_id}').toggle()",:title=>"Changeset #{log_transaction_id}",:class=>'log-entry'})
      if log_name
        xml.a( log_name, :href=>url_for(:controller=>'pentabarf',:action=>:person,:id=>log_person_id))
      end
      xml.div(:id=>"changeset-#{log_transaction_id}") do
        xml.ul do
          send( RenderMatrix[ involved_tables.sort ], xml )
        end
      end
    end
  end

  def render_default( xml )
    involved_tables.each do | table_name |
      log_class( table_name ).select(:log_transaction_id=>log_transaction_id).each do | change |
        case change.log_operation
          when 'U' then 
            render_default_update( xml, table_name, change )
          when 'D' then 
            render_default_delete( xml, table_name, change )
          when 'I' then 
            render_default_insert( xml, table_name, change )
        end
      end
    end
  end

  def render_default_update( xml, table_name, change )
    conditions = {:log_transaction_id=>{:lt=>change.log_transaction_id}}
    life_class(table_name).primary_keys.each do | pk | conditions[pk] = change[pk] end
    old_value = log_class( table_name ).select(conditions,{:order=>Momomoto.desc(:log_transaction_id),:limit=>1})[0]
    old_value ||= log_class( table_name ).new( all_columns( table_name ).inject({}){|h,k| h.merge({k=>nil})} )
    xml.li do
      xml.a({:href=>change_url(table_name, change)}) do
        xml.text! "#{local(table_name)} updated: "
        xml.b change_title(table_name, change)
      end
      xml.ul({:class=>:recent_changes_fields}) do
        changed_columns( change, old_value ).each do | column |
          xml.li do
            if hidden_columns( table_name ).member?( column )
              xml.em "#{local("#{table_name}::#{column}")}"
              xml.text! " changed"
            else
              xml.em "#{local("#{table_name}::#{column}")}:"
              xml.span( column_value(old_value, column), {:class=>:old_value})
              xml << '&rArr;'
              xml.span( column_value(change, column), {:class=>:new_value})
            end
          end
        end
      end
    end
  end

  def render_default_insert( xml, table_name, change )
    xml.li do
      xml.a({:href=>change_url(table_name, change)}) do 
        xml.text! "New #{local(table_name)}: "
        xml.b change_title(table_name, change)
      end
      xml.ul({:class=>:recent_changes_fields}) do
        columns( table_name ).each do | column |
          next unless change[column]
          xml.li do
            xml.em "#{local("#{table_name}::#{column}")}:"
            xml.span( column_value(change, column), {:class=>:new_value})
          end
        end
      end
    end
  end

  def render_default_delete( xml, table_name, change )
    xml.li do
      xml.a({:href=>change_url(table_name, change)}) do 
        xml.text! "#{local(table_name)} deleted: "
        xml.b change_title(table_name, change)
      end
      xml.ul({:class=>:recent_changes_fields}) do
        columns( table_name ).each do | column |
          next unless change[column]
          xml.li do
            xml.em "#{local("#{table_name}::#{column}")}:"
            xml.span( column_value(change, column), {:class=>:old_value})
          end
        end
      end
    end
  end

  def column_value( row, column_name )
    return case column_name
      when :conference_id then
        Conference.select_single({:conference_id=>row[column_name]}).acronym
      when :person_id then
        Person.select_single({:person_id=>row[column_name]}).name
      when :event_id then
        Event.select_single({:event_id=>row[column_name]}).title
      when :account_id then
        Account.select_single({:account_id=>row[column_name]}).login_name
      else
        case row.class.columns[column_name]
          when Momomoto::Datatype::Time_with_time_zone, Momomoto::Datatype::Time_without_time_zone then
            row[column_name].strftime("%H:%M:%S")
          when Momomoto::Datatype::Timestamp_with_time_zone, Momomoto::Datatype::Timestamp_without_time_zone then
            row[column_name].strftime("%Y-%m-%d %H:%M:%S")
        else
          row[column_name].to_s
        end
    end
   rescue => e
    row[column_name].to_s
  end

  def changeset_changes_old( changeset )
    xml.ul do
      Log_transaction_involved_tables.select({:log_transaction_id=>changeset.log_transaction_id}).map(&:table_name).each do | table |
        # FIXME ignoring some tables for now
        next if table == "person_availability"
        klass = table.capitalize.constantize
        log_klass = "Log::#{table.capitalize}".constantize

        log_klass.select(:log_transaction_id=>changeset.log_transaction_id).each do | change |

          # columns with hidden content
          hide_content = [:password,:salt,:activation_string,:css]

          values = []
          columns = klass.columns.keys - [:eval_time,:reset_time,:account_creation]
          columns = columns.map(&:to_s).sort.map(&:to_sym)
          if change.log_operation == "D" || change.log_operation == "I"
            columns = columns - hide_content
            columns.each do | column |
              next if klass.columns[column].instance_of?( Momomoto::Datatype::Bytea )
              next unless change[column]
              next if klass.primary_keys.member?( column ) && column.to_s.match(/_id$/)
              values << "#{local(table.to_s+'::'+column.to_s)}: #{change[column]}"
            end
            next if values.length == 0 && change.log_operation == "I"
          else
            conditions = {:log_transaction_id=>{:lt=>change.log_transaction_id}}
            klass.primary_keys.each do | pk | conditions[pk] = change[pk] end
            old_value = log_klass.select(conditions,{:order=>Momomoto.desc(:log_transaction_id),:limit=>1})[0]
            if old_value
              values = []
              columns.each do | column |
                if change[column] != old_value[column]
                  if klass.columns[column].instance_of?( Momomoto::Datatype::Bytea ) || hide_content.member?(column)
                    values << "#{local(table.to_s+'::'+column.to_s)} changed"
                  else
                    values << "#{local(table.to_s+'::'+column.to_s)}: #{old_value[column]} => #{change[column]}"
                  end
                end
              end
            else
              values << "Couldn't find previous value."
            end
          end

          xml.li do
            link, link_title = change_url( change )

            xml.a({:href=>link,:title=>table}) do
              xml.text! link_title
              xml.br

              xml.b case change.log_operation
                when "D" then "Deleted #{local(table)}: "
                when "I" then "New #{local(table)}: "
                when "U" then "#{local(table)}: "
              end
              xml.text! values.join(", ")
            end
          end
        end

      end
    end
  end

  protected

  def all_columns( table_name )
    columns( table_name ) + hidden_columns( table_name )
  end

  def columns( table_name )
    ( life_class( table_name ).log_content_columns - hidden_columns( table_name ) ).map(&:to_s).sort.map(&:to_sym)
  end

  def hidden_columns( table_name )
    life_class( table_name ).log_hidden_columns.map(&:to_s).sort.map(&:to_sym)
  end

  def change_url( table_name, change )
    url_for( life_class( table_name ).log_change_url( change ) )
   rescue => e
    @controller.instance_eval do
      log_error( e )
    end
    ""
  end

  def change_title( table_name, change )
    life_class( table_name ).log_change_title( change )
   rescue => e
    @controller.instance_eval do log_error( e ) end
    ""
  end

  def url_for( *args )
    @controller.url_for( *args )
  end

  def local( *args )
    @controller.instance_eval do
      local( *args )
    end
  end

  def log_class( table_name )
    "Log::#{table_name.capitalize}".constantize
  end

  def life_class( table_name )
    table_name.capitalize.constantize
  end

  def check_table_changes( table_name, operation )
    changes[table_name.to_sym].length == 1 && changes[table_name.to_sym].first.log_operation == operation.to_s.upcase
  end

  def changed_columns( row1, row2 )
    changed = []
    table_name = row1.class.table.table_name
    ( columns( table_name ) + hidden_columns( table_name ) ).each do | column |
      changed << column if row1[column] != row2[column]
    end
    changed
  end

end

