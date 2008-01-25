module FormTestHelper
  module LinkMethods

    def select_link(text=nil)
      @html_document = nil # So it always grabs the latest response
      if css_select(%Q{a[href="#{text}"]}).any?
        links = assert_select("a[href=?]", text)
      elsif text.nil?
        links = assert_select('a', 1)
      else
        links = assert_select('a', text)
      end
      decorate_link(links.first)
    end
  
    def decorate_link(link)
      link.extend FormTestHelper::Link
      link.testcase = self
      link
    end
    
  end
end