Rails.application.routes.draw do
  root to: 'api_core/info#index'

  match '*path', to: 'application#route_not_found_error', via: [:patch, :get, :post, :delete]
end
