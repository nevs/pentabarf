
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
          local = View_ui_message.select_single(:language_id=>language,:tag=>tag).name
          @cache[language][tag] = local
        rescue
          warn( "unlocalized tag: `#{tag}` for language #{language}" )
          local = tag
        end
      end
      local
    end

  end
end

