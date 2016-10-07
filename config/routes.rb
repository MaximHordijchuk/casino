Rails.application.routes.draw do
  root to: 'main#index'
  post '/' => 'main#update', as: 'update'
end
