class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # LINE ログイン用のコールバックアクションを定義
  def line
    basic_action
  end
  
  private

  # 基本的なアクションを定義
  def basic_action
    @omniauth = request.env["omniauth.auth"]
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      if @profile.email.blank?
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
        @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth)
      sign_in(:user, @profile)
    end
    flash[:notice] = "ログインしました"
    redirect_to root_path
  end

  # 仮想メールアドレスを生成するメソッド
  def fake_email(uid, provider)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
