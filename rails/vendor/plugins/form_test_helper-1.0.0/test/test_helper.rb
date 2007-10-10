unless defined?(RAILS_ROOT)
 RAILS_ROOT = ENV["RAILS_ROOT"] || File.expand_path(File.join(File.dirname(__FILE__), "../../../.."))
end
require File.join(RAILS_ROOT, "test", "test_helper")
require File.join(File.dirname(__FILE__), "..", "init")

class TestController < ActionController::Base
  require 'ostruct'
    
  def index
    render :text => 'foo'
  end
  
  verify :method => :post, :only => [ :create ],
            :redirect_to => { :action => :index }
  def create
    if request.xhr?
      render :text => 'created with xhr'
     else
      render :text => 'created'
    end
  end
  
  verify :method => :delete, :only => [ :destroy ],
            :redirect_to => { :action => :index }
  def destroy
    render :text => 'destroyed'
  end
  
  def redirect_to_back
    redirect_to :back
  end

  def response_with=(content)
    @content = content
  end

  def response_with(&block)
    @update = block
  end

  def rhtml()
    @article = OpenStruct.new("published" => false, "written" => true)
    @book = OpenStruct.new
    render :inline=>(@content || params[:content]), :layout=>false, :content_type=>Mime::HTML
    @content = nil
  end

  def html()
    render :text=>@content, :layout=>false, :content_type=>Mime::HTML
    @content = nil
  end

  def rjs()
    render :update do |page|
      @update.call page
    end
    @update = nil
  end

  def rescue_action(e)
    raise e
  end

end

class OtherController < ActionController::Base
  
end

module Admin
  class NamespacedController < TestController
  
  end
end

# FIXME: This is odd, but I guess you have to or it uses routes & controllers from the app?
ActionController::Routing::Routes.clear!
ActionController::Routing::Routes.draw {|m| m.connect ':controller/:action/:id' }
ActionController::Routing.use_controllers! %w(test other admin/namespaced)

class Test::Unit::TestCase
  protected
    def render_rhtml(rhtml)
      @controller.response_with = rhtml
      get :rhtml
    end

    def render_html(html)
      @controller.response_with = html
      get :html
    end


    def render_rjs(&block)
      @controller.response_with &block
      get :rjs
    end


    def render_xml(xml)
      @controller.response_with = xml
      get :xml
    end
    
    def assert_action_name(expected_name)
      assert_equal expected_name.to_s, @controller.action_name, "Didn't follow link"
    end
end