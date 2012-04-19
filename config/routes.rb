Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :products do
      resource :size_chart
    end

    resources :size_types
  end
end
