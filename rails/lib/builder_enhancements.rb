
require 'builder'

module Builder

  class XmlMarkup

    def textarea( value, options, &block )
      options[:id] ||= options[:name]
      method_missing(:textarea, value, options, &block)
    end

    def form( options, &block )
      options[:method] ||= :post
      method_missing(:form, options) do | xml |
        xml.input({:type=>:hidden,:name=>:token,:id=>"token#{options[:action]}",:value=>Token.generate(options[:action])})
        yield( xml )
      end
    end

  end

end

