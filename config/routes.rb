# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do

  # Jumpstart views
  if Rails.env.development? || Rails.env.test?
    mount Jumpstart::Engine, at: "/jumpstart"
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Administrate
  authenticated :user, lambda { |u| u.admin? } do
    namespace :admin do
      if defined?(Sidekiq)
        require "sidekiq/web"
        mount Sidekiq::Web => "/sidekiq"
      end

      resources :announcements
      resources :users
      namespace :user do
        resources :connected_accounts
      end
      resources :accounts
      resources :account_users
      resources :plans
      namespace :pay do
        resources :charges
        resources :subscriptions
      end

      root to: "dashboard#show"
    end
  end

  # API routes
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resource :auth
      resource :me, controller: :me
      resources :accounts
      resources :users
    end
  end

  # User account
  devise_for :users,
    controllers: {
      masquerades: "jumpstart/masquerades",
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations"
    }

  resources :announcements, only: [:index]
  resources :api_tokens

  resources :accounts do
    member do
      patch :switch
    end

    resources :account_users, path: :members
    resources :account_invitations, path: :invitations, module: :accounts
    resources :ndas
  end

  resources :account_invitations

  get   "listings/public" => "listings#public", as: 'public_listings'

  #Listings
  resources :listings do 
    resources :listing_invitations, path: :invitations, module: :listings do 
      collection do 
        post 'create_batch' => 'listing_invitations#create_batch', as: 'create_batch'
      end 
    end  
    resources :build, controller: 'listings/build'
    resources :nda_signings
    resources :memberships, path: :members

    post :join
    
  end

  resources :listing_invitations

  get 'nda_signings' => 'nda_signings#index', as: :nda_signings

  

  resources :contact_lists, only: [:create]
  resources :contacts
  resources :lists
  resources :activities
  resources :listing_activities, only: [:create]
  resources :contact_activities, only: [:create]
  resources :user_activities, only: [:create]
  
  patch "listings/:id/publish" => "listings#publish", as: 'publish_listing'
  patch "listings/:id/stop" => "listings#stop", as: 'stop_listing'
  patch "listings/:id/start" => "listings#start", as: 'start_listing'
  patch "listings/:id/close" => "listings#close", as: 'close_listing'
  patch "listings/:id/open" => "listings#open", as: 'open_listing'
  get "listings/:id/view" => "listings#view", as: 'view_listing'
  
  # Payments
  resource :card
  resource :subscription do
    patch :info
    patch :resume
  end
  resources :charges
  namespace :account do
    resource :password
  end

  namespace :users do
    resources :mentions, only: [:index]
  end
  namespace :user, module: :users do
    resources :connected_accounts
  end

  resources :embeds, only: [:create], constraints: {id: /[^\/]+/} do
    collection do
      get :patterns
    end
  end

  scope controller: :static do
    get :about
    get :terms
    get :privacy
    get :pricing
  end

  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  authenticated :user do
    root to: "dashboard#show", as: :user_root
  end

  # Public marketing homepage
  root to: "static#index"

  case Rails.configuration.upload_server
  when :s3
    # By default in production we use s3, including upload directly to S3 with
    # signed url.
    mount Shrine.presign_endpoint(:cache) => "/s3/params"
  when :s3_multipart
    # Still upload directly to S3, but using Uppy's AwsS3Multipart plugin
    mount Shrine.uppy_s3_multipart(:cache) => "/s3/multipart"
  when :app
    # In development and test environment by default we're using filesystem storage
    # for speed, so on the client side we'll upload files to our app.
    mount Shrine.upload_endpoint(:cache) => "/upload"
  end
  mount ImageUploader.derivation_endpoint => "/derivations/image"

end
