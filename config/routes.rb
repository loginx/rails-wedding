require 'sidekiq/web'

Weddingwall::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config
  
  authenticate :user do
    mount Sidekiq::Web, :at => "/sidekiq"
  end



  StaticController::Pages.each do |page|
    get page, :controller => 'static', :action => page
  end

  
  resources :rsvps, :only => [:show, :new, :create, :edit, :update]

  root :to => 'static#home'
end
