# app/controllers/users/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
    # カスタムアクションを追加したり、デフォルトのDeviseアクションをオーバーライドすることができます。
    def destroy
      reset_session
      redirect_to root_path, notice: 'ログアウトしました'
    end

  end