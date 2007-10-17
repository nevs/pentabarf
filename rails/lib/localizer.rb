
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
          local = Ui_message_localized.select_single(:language_id=>language,:ui_message=>tag).name
          @cache[language][tag] = local
        rescue Momomoto::Nothing_found
          # warn( "unlocalized tag: `#{tag}` for language #{language}" )
          local = tag.gsub('_',' ').capitalize
        end
      end
      local
    end

    def purge( language_id )
      @cache[language_id] = {}
    end

  end
end

