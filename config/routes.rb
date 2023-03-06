Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do
    get 'about' => 'homes#about'
  
    resources :items, only: [:index, :show]
  
    resources :registrations, only: [:new, :create]
  
    resources :sessioins, only: [:new, :create, :destroy]
  
    resource :customers, only: [:show, :edit, :update]
    get 'unsubscribe' => 'customers#unsubscribe'
    patch 'withdrawal' => 'customers#withdrawal'
  
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete ':id/destroy_all' => 'cart_items#destroy_all'
  
    resources :orders, only: [:new, :create, :index, :show]
    post 'confirm' => 'orders#confirm'
    get 'thanx' => 'orders#thanx'
  end

  namespace :admin do
    resources :sessioins, only: [:new, :create, :destroy]
    get '' => 'admin/homes#top'

    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show]
  end
end