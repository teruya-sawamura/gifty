Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppages#index'
  
  # ユーザ登録用ルーティング
  get 'signup', to: 'users#new'
  resources :users, only:[:show, :create, :edit, :update,] do
    member do
      get :likes
      get :edit_pass
    end
  end
  
  # ログイン用ルーティング
  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'
  
  # 投稿用ルーティング
  resources :posts, only:[:show, :new, :create, :edit, :update, :destroy] do
    get :search, on: :collection
  end
  
  # いいね用ルーティング
  resources :favorites, only:[:create, :destroy]
  
  
end
