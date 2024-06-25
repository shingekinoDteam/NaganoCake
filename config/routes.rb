Rails.application.routes.draw do
  # namespace :admin do
  #   get 'orders/show'
  # end
  # namespace :admin do
  #   get 'customers/index'
  #   get 'customers/show'
  #   get 'customers/edit'
  # end
  # namespace :admin do
  #   get 'genres/index'
  #   get 'genres/edit'
  # end
  # namespace :admin do
  #   get 'items/index'
  #   get 'items/new'
  #   get 'items/show'
  #   get 'items/edit'
  # end
  # namespace :admin do
  #   get 'homes/top'
  # end
  # namespace :public do
  #   get 'addresses/index'
  #   get 'addresses/edit'
  # end
  # namespace :public do
  #   get 'orders/new'
  #   get 'orders/thanks'
  #   get 'orders/index'
  #   get 'orders/show'
  # end
  # namespace :public do
  #   get 'cart_items/index'
  # end
  # namespace :public do
  #   get 'customers/show'
  #   get 'customers/edit'
  #   get 'customers/unsubscribe'
  # end
  # namespace :public do
  #   get 'items/index'
  #   get 'items/show'
  # end
  # namespace :public do
  #   get 'homes/top'
  #   get 'homes/about'
  # end
  # devise_for :customers
  # devise_for :admins

  # 顧客用
# URL /customers/sign_in ...


  # devise_for :customers
  devise_for :customers, controllers: {
    sessions: 'public/customers/sessions',
    registrations: 'public/customers/registrations'
  }
# 管理者用
# URL /admin/sign_in ...



  devise_for :admin
# root to の後のコントローラをpublicに指定してある↓
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
# resourcesの前にgetの記述を移動した
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'
  get 'customers/withdraw' => 'public/customers#withdraw'
  get 'cart_items/destroy_all' => 'public/cart_items#destroy_all'
  post 'orders/confirm' => 'public/orders#confirm'
  get 'orders/thanks' => 'public/orders#thanks'

  get 'admin' => 'admin/homes#top'

scope module: :public do
  resources :items, only: [:index, :show]

# resourceとscopeで上手くいかなかった↓
  get 'customers/my_page' => 'customers#show'
  get 'customers/information/edit' => 'customers#edit'
  patch 'customers/information' => 'customers#update'

  resources :cart_items, only: [:index, :create, :update, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end

  resources :orders, only: [:new, :create, :index, :show]
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      patch 'order_details/:id', to: 'orders#update_order_detail', as: 'update_order_detail'
    end
  end
get '/genre/search' => 'searches#genre_search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
