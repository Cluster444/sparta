require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def access_denied
      raise CanCan::AccessDenied
    end

    def timezone
      @time_zone = Time.zone
      @time_now = Time.zone.now.iso8601
      render nothing: true
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

  context 'when an action is called' do
    before { routes.draw { get "timezone" => "anonymous#timezone" } }

    context 'and a player is signed in' do
      let(:user) { create :user }
      let(:player) { create :player, user: user }
      before { sign_in user }

      context 'and the player has set their time zone' do
        before { player.update(timezone: 'Eastern Time (US & Canada)') }

        it 'sets the time zone to the users time zone' do
          Timecop.freeze 'Jan 14th, 2014 10:00 UTC' do
            get :timezone
            expect(assigns(:time_zone).name).to eq 'Eastern Time (US & Canada)'
            expect(assigns(:time_now)).to eq '2014-01-14T05:00:00-05:00'
          end
        end
      end

      context 'and the player has not set their time zone' do
        it 'sets the time zone to UTC' do
          Timecop.freeze 'Jan 14th, 2014 10:00 UTC' do
            get :timezone
            expect(assigns(:time_zone).name).to eq 'UTC'
            expect(assigns(:time_now)).to eq '2014-01-14T10:00:00Z'
          end
        end
      end
    end

    context 'and not signed in' do
      it 'sets the time zone to UTC' do
        Timecop.freeze 'Jan 14th, 2014 10:00 UTC' do
          get :timezone
          expect(assigns(:time_zone).name).to eq 'UTC'
          expect(assigns(:time_now)).to eq '2014-01-14T10:00:00Z'
        end
      end
    end
  end
end
