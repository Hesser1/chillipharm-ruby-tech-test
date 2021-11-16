Rails.application.routes.draw do
  root to: "libraries#index"

  resources :users
  resources :libraries do
    member do
      get :info
      get :save_search
      post :save_search, to: "saved_searches#create"
      delete :save_search, to: "saved_searches#delete"
    end

    resources :assets do
      resources :comments

      collection do
        get :delete
        delete :delete
      end
    end    
  end
end
