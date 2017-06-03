Rails.application.routes.draw do
  delete '/albums/:album_id/delete_selected', to: "photos#delete_selected", as: 'delete_selected'
  delete '/albums/:album_id/delete_all', to: "photos#delete_all", as: 'delete_all'

  resources :posts
  resources :photos, only: [:index]
  resources :albums do
    resources :photos, only: [:create]
  end
  post '/tinymce_assets' => 'posts#upload_image'
  devise_for :admins
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
