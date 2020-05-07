Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books

  root 'home#top'
  get 'home/about'

  resources :books, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
	end
  
 #  resources :users,only: [:show,:index,:edit,:update] do
 #  resources :relationships, only: [:create, :destroy]
	# end
  resources :relationships, only: [:create, :destroy]
  get 'users/:id/follows' => 'relationships#index', as: 'index_relationship'
  get 'users/:id/followers' => 'relationships#new', as: 'new_relationship'

  get  'serched' => 'searches#search',  as: 'search'
  get  'serch_book' => 'searches#index',  as: 'search_book'
  get  'serche_user' => 'searches#new',  as: 'search_user'

  get 'maps/index'
end

