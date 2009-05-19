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
  map.connect '', :controller => 'pentabarf'

  map.connect 'schedule/:conference', :controller => 'schedule', :action => 'index', :language => 'en'
  map.connect 'schedule/:conference/index.:language.html', :controller => 'schedule', :action => 'index'
  map.connect 'schedule/:conference/day/:id.:language.html', :controller => 'schedule', :action => 'day'
  map.connect 'schedule/:conference/speakers.:language.html', :controller => 'schedule', :action => 'speakers'
  map.connect 'schedule/:conference/speaker/:id.:language.html', :controller => 'schedule', :action => 'speaker'
  map.connect 'schedule/:conference/events.:language.html', :controller => 'schedule', :action => 'events'
  map.connect 'schedule/:conference/event/:id.:language.html', :controller => 'schedule', :action => 'event'
  map.connect 'schedule/:conference/day/:id.:language.html', :controller => 'schedule', :action => 'day'
  map.connect 'schedule/:conference/track/:track/index.:language.html', :controller => 'schedule', :action => 'track_events', :track=> /[^\/]+/
  map.connect 'schedule/:conference/track/:track/:id.:language.html', :controller => 'schedule', :action => 'track_event', :track=> /[^\/]+/
  map.connect 'schedule/:conference/style.css', :controller => 'schedule', :action => 'css'
  map.connect 'schedule/:conference/:action.:language.html',:controller => 'schedule'
  map.connect 'schedule/:conference/:action/:id.:language.html',:controller => 'schedule'

  map.connect 'feedback/:conference/style.css',:controller => 'feedback', :action => 'css'
  map.connect 'feedback/:conference/:action/:id.:language.html',:controller => 'feedback'

  map.connect 'submission/:conference/:action/:id', :controller => 'submission'

  map.connect 'image/:action/:id.:size.:extension', :controller=> 'image'
  map.connect 'image/:action/:id.:size', :controller=> 'image'

  map.connect 'ical/:action/:conference', :controller=> 'ical'
  map.connect 'xcal/:action/:conference', :controller=> 'xcal'
  map.connect 'xml/:action/:conference', :controller=> 'xml'

  map.connect 'pentabarf/events_by_state/:event_state', :controller => 'pentabarf', :action => 'events_by_state'
  map.connect 'pentabarf/events_by_state/:event_state/:event_state_progress', :controller => 'pentabarf', :action => 'events_by_state'

  map.connect 'conference/:action/:conference_id', :controller => 'conference', :conference_id => /\d+/
  map.connect 'event/:action/:event_id', :controller => 'event', :event_id => /\d+/
  map.connect 'person/:action/:person_id', :controller => 'person', :person_id => /\d+/

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
