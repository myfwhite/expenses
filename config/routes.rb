ActionController::Routing::Routes.draw do |map|

  map.resources :expenses,
                :collection => {:search => :get, :search_results => :get},
                :member => {:download => :get}
  
  map.connect '/user/:action', :controller => :users
  map.root :controller => 'users', :action => 'login'
  map.login 'login', :controller => :users, :action => 'login'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'

end
