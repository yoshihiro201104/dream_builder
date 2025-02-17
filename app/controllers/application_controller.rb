class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_users_path  # 管理者用のユーザー一覧ページにリダイレクト
    else
      user_path(resource)  # ユーザーの場合は通常のページへ
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      new_admin_session_path  # 管理者がログアウトした後に管理者ログインページへリダイレクト
    else
      new_user_session_path  # ユーザーがログアウトした後にユーザーログインページへリダイレクト
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
