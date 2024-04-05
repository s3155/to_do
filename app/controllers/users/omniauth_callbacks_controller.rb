class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :google_oauth2
  
    def google_oauth2
      callback_for(:google) # provider パラメータを渡す
    end
  
    def callback_for(provider)
      @user = User.from_omniauth(request.env['omniauth.auth'])
  
      if @user.present? && @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
      else
        flash[:alert] = 'Authentication failed.'
        redirect_to new_user_registration_url
      end
    end
  
    def failure
      redirect_to root_path
    end
  end
  