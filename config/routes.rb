Rails.application.routes.draw do

  resources :days

  resources :recurring_periods

  resources :recurring_schedule_exceptions

  resources :recurring_schedules

  resources :levels

  resources :practices

  resources :credentials

  resources :styles

  resources :institutes

  resources :certificates

  resources :instructors do
    resources :non_recurring_hours
    resources :recurring_available_hours
  end
  resources :instructors
  get 'instructors/:id/new_certificate' => "instructors#new_certificate", :as => "instructor_new_certificate"
  post "instructors/:id/save_certificate"  => "instructors#save_certificate", :as => "save_certificate"
  get 'instructors/:id/new_style' => "instructors#new_style", :as => "instructor_new_style"
  post "instructors/:id/save_style"  => "instructors#save_style", :as => "save_style"
  get 'instructors/:id/schedules' => "instructors#schedules", :as => "instructor_schedules"
  post "instructors/:id/schedules"  => "instructors#create_schedule", :as => "create_schedule"

  post 'instructors/:id/schedules/get_ocurrences' => "instructors#get_occurrences", :as  => "get_occurrences"

  post '/instructor/:instructor_id/non_recurring_hours' => "non_recurring_hours#create", as: "create_non_recurring_hour"

  get 'loginfo' => "loginfo#index"

  get '/search' => 'welcome#search'

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
