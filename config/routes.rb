Rails.application.routes.draw do
  get 'link/index'

  post 'member/register'

  get 'referral/add'

  get 'referral/:id', to: "referral#index"

  post 'referral/view', to: "referral#view"

  post "l/:id", to: "link#post"

  get "l/:id", to: "link#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
