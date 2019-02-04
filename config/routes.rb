Rails.application.routes.draw do
  
  root "welcome#index"

  get("/my_quiz_history", to:"users#my_scores")

  resources :quizzes do
    resources :scores
    resources :questions, shallow: true do
      resources :answers
    end
  end

  # resources :users, only: [:new, :create] do
  #   resources :scores
  # end

  resources :users, only: [:new, :create]
  
  resource :session, only: [:new, :create, :destroy]
  
end
