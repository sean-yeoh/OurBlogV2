Rails.application.routes.draw do
  resources :posts
  post '/tinymce_assets' => 'posts#upload_image'
  devise_for :admins
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
