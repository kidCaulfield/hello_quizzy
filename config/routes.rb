Rails.application.routes.draw do
  
  root "welcome#index"

  resources :quizzes do
    resources :questions, shallow: true do
      resources :answers
    end
  end

  resources :users, only: [:new, :create] do
    resources :scores
  end

  resource :session
  
end
