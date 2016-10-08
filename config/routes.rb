Rails.application.routes.draw do
  root to: 'main#index'
  put '/user_update' => 'main#update', as: 'user_update'
  get '/poker_tables' => 'main#poker_tables', as: 'poker_tables'
end
