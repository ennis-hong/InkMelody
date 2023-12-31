class ApplicationController < ActionController::Base
  around_action :switch_locale
  # include UsersHelper
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :current_user, :user_signed_in?, :current_cart

  private

  def default_url_options
    { lang: I18n.default_locale }
  end

  def switch_locale(&action)
    lang =  params[:lang] || I18n.default_locale
    I18n.with_locale(lang, &action)
  end

  def current_cart
    if user_signed_in?
      # 使用實體變數達到 memorization 避免重複查詢
      @__cart__ ||= ( current_user.cart || current_user.create_cart )
    else
      Cart.new
    end
  end

  def current_user
    # 使用實體變數達到 memorization 避免重複查詢
    @__user__ ||= User.find_by(id: session[:__user_ticket__])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    if not user_signed_in?
      respond_to do |format|
        format.html {redirect_to sign_in_users_path, alert: '請先登入'}
        format.json {
          render json: {
            message: '請登入帳號',
            next: sign_in_users_path }, status: 401
        }
      end
    end
  end

  def not_found
    render file: Rails.public_path.join('404.html'),
      status: 404
      # layout: false
  end
end
