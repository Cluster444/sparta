class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout proc {|c| c.request.xhr? ? false : 'application'}

  rescue_from CanCan::AccessDenied do
    redirect_to new_user_session_path, alert: 'Sign in to continue'
  end
end
