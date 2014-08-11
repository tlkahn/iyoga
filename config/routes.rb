Rails.application.routes.draw do

  resources :instructors do
    resources :non_recurring_hours
    resources :recurring_available_hours
  end
  resources :instructors

  post '/instructor/:instructor_id/non_recurring_hours' => "non_recurring_hours#create", as: "create_non_recurring_hour"

  get 'loginfo' => "loginfo#index"

  resources :messages

  resources :students
  post 'students/:id/messages' => "students#create"
  get '/inbox' => "messages#gotoinbox"
  get '/allmessages' => "messages#show_all"
  get '/messages/remove/:id' => "messages#delete_by_receipient", :as => "remove_message"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: "registrations" }

  get 'users/:user_id/schedule'  => "instructors#schedule", as: "user_schedule"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
