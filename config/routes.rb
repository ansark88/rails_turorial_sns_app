Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'  #resourcesメソッドでusers#createはルーティング済なので必要ない？
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  #resourcesメソッドを使うとユーザーのURLを生成するための
  #多数の名前付きルート と共に、RESTfulなUsersリソースで
  #必要となるすべてのアクションが利用できるようになる
  resources :users
end
