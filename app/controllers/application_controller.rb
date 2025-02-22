class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログイン後のページ
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_users_path  # 管理者用のユーザー一覧ページにリダイレクト
    else
      user_path(resource)  # ユーザーの場合は通常のページへ
    end
  end

  # ログアウト後のリダイレクト先を指定
  def after_sign_out_path_for(resource_or_scope)
    # オーバーライドして親クラスのリダイレクト先を子クラスで上書きしている
    if resource_or_scope == :admin
      new_admin_session_path # 管理者の場合は管理者のログインページへ
    else
      new_user_session_path # 一般ユーザーの場合はユーザーのログインページへ
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

    # 管理者認証を追加
    def authenticate_admin!
      unless admin_signed_in?
        redirect_to new_admin_session_path, alert: '管理者としてログインしてください'
      end
    end
    
end
