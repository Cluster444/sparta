require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def access_denied
      raise CanCan::AccessDenied
    end
  end

  context 'when access is denied' do
    before { routes.draw { get "access_denied" => "anonymous#access_denied" } }

    context 'and the user is not signed in' do
      it 'redirects to the sign in page' do
        get :access_denied
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'flashes that the user should sign in to continue' do
        get :access_denied
        expect(flash[:alert]).to match(/sign in to continue/i)
      end
    end
  end
end
