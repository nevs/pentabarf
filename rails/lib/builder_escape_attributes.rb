
require 'builder'
require 'builder/xmlmarkup'
require 'builder/xmlevents'

module Builder

  class XmlMarkup < XmlBase
    # Insert the attributes (given in the hash).
    def _insert_attributes(attrs, order=[])
      return if attrs.nil?
      order.each do |k|
        v = attrs[k]
        @target << %{ #{_escape(k.to_s)}="#{_escape_value(v)}"} if v
      end
      attrs.each do |k, v|
        @target << %{ #{_escape(k.to_s)}="#{_escape_value(v)}"} unless order.member?(k)
      end
    end

    def _escape_value(v)
      _escape(v.to_s).gsub('"','&quot;')
    end
  end
end
