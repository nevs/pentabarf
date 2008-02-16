
# class responsible for looking up localized strings
class Localizer

  @cache = Hash.new do | hash, key | hash[key] = Hash.new end

  class << self

    # lookup localization for tag and cache it
    def lookup( tag, language )
      tag = tag.to_s
      local = @cache[language][tag]
      if not local
        begin
          local = Ui_message_localized.select_single(:translated=>language,:ui_message=>tag).name
          @cache[language][tag] = local
        rescue Momomoto::Nothing_found
          if POPE.permission?( :modify_localization )
            ui_msg = Ui_message.select_or_new( :ui_message => tag )
            if ui_msg.new_record?
              logger.warn( "creating ui_message `#{tag}`" )
              ui_msg.write 
            end
          end
          logger.debug( "unlocalized tag: `#{tag}` for language #{language}" )
          local = tag.gsub('_',' ').capitalize
        end
      end
      local
    end

    def purge( language )
      @cache[language] = {}
    end

  end
end

