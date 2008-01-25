module FormTestHelper
  module RequestMethods 

    def make_request(method, path, params={}, referring_uri=nil, use_xhr=false)
      if self.kind_of?(ActionController::IntegrationTest) 
        if use_xhr
          params = {'_method' => method }.merge(params)
          xml_http_request :post, path, params
        else
          self.send(method, path, params.stringify_keys, {:referer => referring_uri})
        end
      else
        params.merge!(ActionController::Routing::Routes.recognize_path(path, :method => method))
  #      if params[:controller] && params[:controller] != current_controller = self.instance_eval("@controller").controller_path
  #        raise "Can't follow links outside of current controller (from #{current_controller} to #{params[:controller]})"
  #      end
        self.instance_eval("@request").env["HTTP_REFERER"] ||= referring_uri # facilitate testing of redirect_to :back
        if use_xhr
          self.xhr(method, params.delete(:action), params.stringify_keys)
        else
          self.send(method, params.delete(:action), params.stringify_keys)
        end
      end
    end

  end
end
