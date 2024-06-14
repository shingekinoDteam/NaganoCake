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
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
# root to の後のコントローラをpublicに指定してある↓
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
# resourcesの前にgetの記述を移動した
  get 'customers/unsubscribe' => 'public/customers#unsubscribe'
  get 'customers/withdraw' => 'public/customers#withdraw'
  get 'cart_items/destroy_all' => 'public/cart_items#destroy_all'
  get 'orders/confirm' => 'public/orders#confirm'
  get 'orders/thanks' => 'public/orders#thanks'

  get 'admin' => 'admin/homes#top'

scope module: :public do
  resources :items, only: [:index, :show]

# resourceとscopeで上手くいかなかった↓
  get 'customers/my_page' => 'customers#show'
  get 'customers/information/edit' => 'customers#edit'
  patch 'customers/information' => 'customers#update'

  resources :cart_items, only: [:index, :update, :destroy]
  resources :orders, only: [:new, :create, :index, :show]
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
end


namespace :admin do
  resources :items, only: [:index, :new, :create, :show, :edit,  :update]
  resources :genres, only: [:index, :create, :edit,  :update]
  resources :customers, only: [:index, :show, :edit,  :update]
  resources :orders, only: [:show,  :update] do
    resources :order_details, only: [:update]
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
