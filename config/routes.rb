Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/messages", to: "messages#index"
  get "/room_chat", to: "room_chat#index"

  post "/room_chat/add", to: "room_chat#add"
  post "/messages/send", to: "messages#send_msg"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
