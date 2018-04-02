Rails.application.routes.draw do
  post 'member/register'

  get 'referral/add'

  get 'referral/:id', to: "referral#index"

  post 'referral/view/:id', to: "referral#view"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
