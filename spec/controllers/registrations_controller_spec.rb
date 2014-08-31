require 'rails_helper'

RSpec.describe RegistrationsController do
  let(:player_params) { {name: 'John Smith', email: 'john@smith.com', password: 'password', password_confirmation: 'password'} }

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  context 'when registering a new account' do
    it 'creates a registration with the given params' do
      expect(PlayerRegistration).to receive(:new).with(player_params).and_call_original

      post :create, user: player_params
    end

    it 'saves the user reigstration' do
      registration = PlayerRegistration.new(player_params)
      allow(PlayerRegistration).to receive(:new).and_return(registration)

      expect(registration).to receive(:save).and_call_original

      post :create, user: player_params
    end

    it 'redirects to the player path' do
      registration = PlayerRegistration.new(player_params)
      allow(PlayerRegistration).to receive(:new).and_return(registration)

      post :create, user: player_params
      expect(response).to redirect_to(player_path(registration.player))
    end
  end
end
