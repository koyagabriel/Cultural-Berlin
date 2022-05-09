Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/web-sources", controller: :web_sources, action: :index
  get "/activities", controller: :cultural_activities, action: :index
  get "/activities/search", controller: :cultural_activities, action: :search
end
