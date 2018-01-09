Rails.application.routes.draw do
  root "homepages#index"
  devise_for :users, only: [:sessions]
  namespace :api do
    namespace :v1 do
      use_doorkeeper do
        controllers tokens: "sessions"
      end
    end
  end
end
