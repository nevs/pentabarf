require 'markup_writer'

module Markup
  class HTMLWriter < Writer
    tag_writer :paragraph, 'p'
    tag_writer :blockquote, 'dd'
    tag_writer :ordered_list, 'ol'
    tag_writer :unordered_list, 'ul'
    tag_writer :list_item, 'li'
    tag_writer :italic, 'i'
    tag_writer :bold, 'b'
    tag_writer :underline, 'u'


    def initialize
      @opened_headlines = []
    end

    def open_link(href)
      "<a href=\"#{href}\">"
    end
    def close_link
      '</a>'
    end

    def open_headline(level)
      @opened_headlines << level
      "<h#{level}>"
    end
    def close_headline
      level = @opened_headlines.pop
      if level
        "</h#{level}>"
      else
        raise 'Markup attempting to close a headline where none was opened'
      end
    end
  end
end
