Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
    #get 'zendesk/sso'

    get 'zendesk/sso/sign_in', to: 'zendesk#sign_in'

    get 'zendesk/sso/sign_out', to: 'zendesk#sign_out'

  root to: "pages#index"

end
