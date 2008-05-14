
# class responsible for looking up localized strings
class Localizer

  @cache = Hash.new do | hash, key | hash[key] = Hash.new end

  class << self

    def logger
      RAILS_DEFAULT_LOGGER
    end

    # lookup localization for tag and cache it
    def lookup( tag, language, arguments = {} )
      tag = tag.to_s
      local = @cache[language][tag]
      if not local
        begin
          local = Ui_message_localized.select_single(:translated=>language,:ui_message=>tag).name
          @cache[language][tag] = local
        rescue Momomoto::Nothing_found
          ui_msg = Ui_message.select_or_new( :ui_message => tag )
          if ui_msg.new_record?
            logger.warn( "creating ui_message `#{tag}`" )
            Ui_message.__write( ui_msg )
          end
          logger.debug( "unlocalized tag: `#{tag}` for language #{language}" )
          local = tag
        end
      end
      local.gsub(/#\{[a-z0-9]+\}/) do | match |
        arguments[ match[2..-2].to_sym ]
      end
    end

    def purge( language )
      @cache[language] = {}
    end

  end
end

