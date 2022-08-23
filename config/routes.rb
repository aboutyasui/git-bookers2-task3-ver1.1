Rails.application.routes.draw do

  devise_for :users
  resources :books
  patch 'books/:id' => 'books#update', as: 'update_book'
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'

  resources :users,only: [:index, :show, :edit, :update]#投稿には、「新規投稿」「一覧」「詳細機能」「削除」「編集」「更新」しか使わないため
  patch 'users/:id' => 'users#update', as: 'update_user'

  #get 'books/new'
  #get 'books/index'
  #get 'books/show'
  #get 'books/edit'
  #get 'books/update'
  #get 'books/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"homes#top"
  get 'home/about'=>'homes#about' ,as:'about'

end
