ActionController::Routing::Routes.draw do |map|
  # Add your own custom routes here.
  # The priority is based upon order of creation: first created -> highest priority.

  # Here's a sample route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  #map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect '', :controller => 'pentabarf'
  map.connect 'schedule/:conference_id/stylesheet.css', :controller => 'schedule', :action => 'css'
  map.connect 'schedule/:conference_id/:action/:id', :controller => 'schedule'
  map.connect 'feedback/:conference_id/:action/:id', :controller => 'feedback'
  map.connect 'submission/:conference/:action/:id', :controller => 'submission'
  map.connect ':controller/:action/:id'
end
