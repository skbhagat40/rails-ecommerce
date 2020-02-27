Rails.application.routes.draw do
  delete '/wishlist/:id', to: "wishlists#destroy", as: "destroy_user_wishlist"
  get '/seller-history', to: "home_pages#seller_history", as: "seller_history"
  get '/search', to: "home_pages#search", as: "search"
  get '/my-orders', to: "orders#my_orders", as: "my_orders"
  post '/create-order', to: "orders#create_order", as: "create_order"
  get '/checkout', to: "home_pages#checkout", as: "checkout"
  get 'order-summary', to: "orders#order_summary", as: "order_summary"
  post '/users/:user_id/address', to: "addresses#create", as: "create_user_address"
  put '/users/:user_id/address/:id', to: "addresses#update", as: "update_user_address"
  delete '/users/:user_id/address/:id', to: "addresses#destroy", as: "delete_user_address"
  put '/products/update', to: "carts#update_cart_item", as: "update_cart_item"
  delete '/products/:product_id', to: "carts#delete_cart_item", as: "delete_cart_item"
  post '/products/:product_id/reviews/new', to: "reviews#create", as: "create_product_review"
  put '/products/:product_id/reviews/:id', to: "reviews#update", as: "update_product_review"
  delete '/products/:product_id/reviews/:id', to: "reviews#destroy", as: "destroy_product_review"
  get '/wishlist', to: "wishlists#my_wishlist", as: "my_wishlist"
  get '/cart', to: "carts#my_cart", as: "my_cart"
  post '/products/add', to: "carts#add_product_to_cart", as: "add_product_to_cart"
  post '/products/wishlist', to: "wishlists#add_product_to_wishlist", as: "add_product_to_wishlist"
  get '/products/category/:category_id', to: "home_pages#products_by_category", as: "products_by_category"
  get '/products/:id', to: "products#show", as: "product_show"
  delete '/products/:id/image/:image_id', to: "products#remove_product_image", as: "remove_product_image"
  post '/sellers/:seller_id/products/new', to: "products#create"
  delete '/sellers/:seller_id/products/:id', to: "products#destroy", as: "delete_seller_product"
  put '/sellers/:seller_id/products/:id', to: "products#update", as: "update_seller_product"

  resources :sellers do
    resources :products
  end
  resources :products do
    resources :reviews
  end
  root to: "home_pages#index"
  get 'home_pages/index'
  devise_for :users, controllers: {sessions: 'users/sessions', :registrations => "users/registrations",
  }
  resources :users do
    resources :addresses
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

