ActionController::Routing::Routes.draw do |map|

  map.resources :expenses,
                :controller => :expense,
                :collection => {:search => :get, :search_results => :get},
                :member => {:download => :get}
  
  map.connect '/user/:action', :controller => :user
  map.root :controller => 'user', :action => 'login'
  map.login 'login', :controller => :user, :action => 'login'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'

end
