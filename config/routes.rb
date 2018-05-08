Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'
 
  devise_for :users
 
  resources :events 
  resources :users, :only => [:show]

  post 'events/:id/subscribe', to: 'events#subscribe', as: 'event_subscription'

end