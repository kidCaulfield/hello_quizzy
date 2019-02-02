Rails.application.routes.draw do
  
  root "welcome#index"
  
  resources :quizzes do
    resources :questions do
      resources :answers 

    end
  end
      
      
  resources :users do
    resources :scores
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
