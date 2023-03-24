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

    resource :customer, only: [:show, :edit, :update]
    get 'unsubscribe' => 'customer#unsubscribe'
    patch 'withdrawal' => 'customer#withdrawal'

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete ':id/destroy_all' => 'cart_items#destroy_all'

    resources :orders, only: [:new, :create, :index, :show]
    post 'confirm' => 'orders#confirm'
    get 'thanx' => 'orders#thanx'
  end

  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy]
    get '' => 'homes#top'

    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show]
  end
end