class PagesController < ApplicationController
  def show
    begin
      render params[:id]
    rescue ActionView::MissingTemplate
      render nothing: true, status: :not_found
    end
  end

  def home
    if user_signed_in?
      redirect_to player_path(user.player)
    end
  end
end
