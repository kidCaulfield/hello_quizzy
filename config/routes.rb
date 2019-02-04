Rails.application.routes.draw do
  
  root "welcome#index"

  resources :quizzes 
  resources :questions 
  resources :answers 
  resources :scores
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
