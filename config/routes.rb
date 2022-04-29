include DynamicRouter

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # include dynamic routes from Page model
  hung_pham_cms_load
end
