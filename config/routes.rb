Rails.application.routes.draw do
  root 'task#index'
  post 'tasks', to: 'task#create'
end
