Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :messages, only: [:index] do
    collection do
      post 'send', to: 'messages#send_msg'
    end
  end

  resources :room_chat, only: [:index, :show], param: :room_id do
    collection do
      post 'add', to: 'room_chat#add'
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
