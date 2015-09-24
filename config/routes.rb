BaseApp::Application.routes.draw do

  resources :cliqs, path: "c" do
    resources :topics, path: "t", :except => [:index] do
      resources :replies
    end
    member do
      get :admin
    end
  end

  resources :tomatometers
  resources :mariomaker do
    collection do
      authenticate :user do
        resources :mario_levels, :path => 'levels', only: [:new, :create, :edit, :destroy, :update] do
          member do
            resources :mario_ratings, path: 'rate'
          end
        end
        resources :mario_user_comments
      end
      resources :mario_levels, :path => 'levels', only: [:index, :show]
    end
  end

  resources :favorites, only: [:update] do
    collection do
      get :do_reset_session
    end
  end

  resources :topic_report do
    member do
      post :report
      get :report_ajax
    end
  end

  root :to => "cliqs#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }

  get "pages/index"
  get "/admin" => "admin/base#index", :as => "admin"
  namespace "admin" do
    resources :users
    resources :reports
  end
  resources :users, only: [:show] do
    member do
      get :marioprofile
    end
  end
  resources :bookmarks, only: [:update]


  get "pages/not_authorized"

end
