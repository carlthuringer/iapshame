Rails.application.routes.draw do
  get '/', :to => "games#index"
end
