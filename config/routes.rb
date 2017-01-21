Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Link
  get '/link/:id', to: 'links#show', as: 'links'
  get '/share-link', to: 'links#new'
  post '/link/create', to: 'links#create'
  get '/', to: 'links#index', as: 'index'

  # Comment
  post '/link/:link_id/new-comment', to: 'comments#new', as: 'new_comment'

  # Session
  get '/login', to: 'sessions#index'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  # User
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  # PasswordRecovery
  get '/forgot-password', to: 'password_recovery#forgot_password'
  post '/password-recovery', to: 'password_recovery#password_recovery'
  get '/change-password', to: 'password_recovery#change_password'
  post '/changing-password', to: 'password_recovery#changing_password'


  # Give point
  get '/link/:link_id/give-point', to: 'points#give_point_to_link', as: 'give_point'
  get '/comment/:comment_id/give-point', to: 'points#give_point_to_comment', as: 'give_point_to_comment'

  # Get links as json
  get '/get-popular-links/:page', to: "links#get_popular_links"
  get '/get-newest-links/:page', to: "links#get_newest_links"
  post '/get-search-results/:page', to: "links#get_search_results"

  get '/get-link/:id', to: "links#get_link"
  get '/get-comments/:link_id', to: "comments#get_comments"

end
