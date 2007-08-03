
require 'builder'

module Builder

  class XmlMarkup

    def form( options, &block )
      method_missing(:form, options) do | xml |
        xml.input( nil, {:type=>:hidden,:name=>:token,:value=>Token.generate(options[:action])})
        yield( xml )
      end
    end

  end

end

