ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "pentabarf"

  map.connect 'schedule/:conference/track/:track', :controller => 'schedule', :action => 'track_events'
  map.connect 'schedule/:conference/track/:track/:id', :controller => 'schedule', :action => 'track_event'
  map.connect 'schedule/:conference/:action/:id', :controller => "schedule"
  map.connect 'schedule/:conference/style.css',:controller => "schedule", :action => 'css'

  map.connect 'feedback/:conference/style.css',:controller => "feedback", :action => 'css'
  map.connect 'feedback/:conference/:action/:id.:language.html',:controller => "feedback"

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
