Rails.application.routes.draw do
  root 'binaries#index'
  resources :binaries do 
    collection do 
     post 'binary-search'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
