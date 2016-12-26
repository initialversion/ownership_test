Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "things#index"
  # Routes for the Thing resource:
  # CREATE
  get "/things/new", :controller => "things", :action => "new"
  post "/create_thing", :controller => "things", :action => "create"

  # READ
  get "/things", :controller => "things", :action => "index"
  get "/things/:id", :controller => "things", :action => "show"

  # UPDATE
  get "/things/:id/edit", :controller => "things", :action => "edit"
  post "/update_thing/:id", :controller => "things", :action => "update"

  # DELETE
  get "/delete_thing/:id", :controller => "things", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
