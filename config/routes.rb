Rails.application.routes.draw do

  namespace :admin do
    get 'event_comments/index'
  end
  # 顧客用
  # URL /end_users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    resources :events, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :bookmarks, only: [:create, :destroy]
      resources :event_comments, only: [:create, :destroy]
      resources :groups do
        get "join" => "groups#join"
        delete "all_destroy" => "groups#all_destroy"
      end
      collection do
        get "search"
      end
    end
    #タグによって絞り込んだ投稿を表示するアクションへのルーティング
    resources :tags do
      get 'events', to: 'events#searchtag'
    end
    resources :users, only: [:show, :edit, :update, :mybookmark] do
      get :check, on: :collection
      patch :withdrawal, on: :collection
      get :bookmark, on: :collection #ブックマーク
    end
  end

  #ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :event_comments, only: [:index, :destroy]
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end
