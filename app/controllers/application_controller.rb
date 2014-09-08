class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :set_time_zone, if: :current_user

  layout proc {|c| c.request.xhr? ? false : 'application'}

  rescue_from CanCan::AccessDenied do
    redirect_to new_user_session_path, alert: 'Sign in to continue'
  end

  private

  def set_time_zone(&block)
    Time.use_zone(current_user.player.try(:timezone), &block)
  end
end
