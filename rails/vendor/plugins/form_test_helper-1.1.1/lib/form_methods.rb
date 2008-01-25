module FormTestHelper
  module FormMethods
    
    def select_form(text=nil, use_xhr=false)
      @html_document = nil # So it always grabs the latest response
      forms = case
      when text.nil?
        assert_select("form", 1)
      when css_select(%Q{form[action="#{text}"]}).any?
        assert_select("form[action=?]", text)
      else
        assert_select('form#?', text)
      end
    
      returning Form.new(forms.first, self) do |form|
        if block_given?
          yield form
          form.submit :xhr => use_xhr
        end
      end
    end
  
    # Alias for select_form when called with a block. 
    # Shortcut for select_form(name).submit(args) without block.
    def submit_form(*args, &block)
      if block_given?
        if args[0].is_a?(Hash)
          select_form(nil, args[0].delete(:xhr), &block)
        else
          select_form(*args, &block)
        end
      else
        selector = args[0].is_a?(Hash) ? nil : args.shift
        select_form(selector).submit(*args)
      end
    end
    
  end
end