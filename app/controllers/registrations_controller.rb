class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    super do
      self.resource = resource.user
    end
  end

  def build_resource(player_params)
    self.resource = PlayerRegistration.new(player_params)
  end

  def after_sign_up_path_for(resource)
    player_path(resource.player)
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << [:name]
  end
end
