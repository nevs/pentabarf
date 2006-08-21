
require 'erubis'

class ErubisHandler
  def initialize( view )
    @view = view
  end

  def render( template, local_assigns )
    eruby = Erubis::EscapedEruby.new( template )
    if local_assigns.is_a?(Hash)
      eval local_assigns.keys.inject("") {|s,k| s << "#{k} = local_assigns[#{k.inspect}];"}
    end
    eruby.result( binding )
  end
end

