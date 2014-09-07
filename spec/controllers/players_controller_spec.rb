require 'rails_helper'

RSpec.describe PlayersController do
  let(:authenticatable) { create :user }
  let(:user) { authenticatable }

  it_behaves_like 'an authenticated controller', {
    index: [:get, {}],
    show: [:get, {id: 1}],
    edit: [:get, {id: 1}],
    update: [:patch, {id: 1}],
  }

  describe 'authorization' do
    before { bypass_rescue }

    context 'when a user is signed in' do
      before { sign_in user }

      it 'they cannot access the index' do
        expect {
          get :index
        }.to raise_error(CanCan::AccessDenied)
      end

      context 'and is accessing a player belonging to them' do
        let(:player) { create :player, user: user }

        it 'they can view the player' do
          expect {
            get :show, id: player.id
          }.not_to raise_error
        end

        it 'they can update the player' do
          expect {
            get :edit, id: player.id
          }.not_to raise_error

          expect {
            patch :update, id: player.id, player: {name: 'test'}
          }.not_to raise_error
        end
      end

      context 'and is accessing a player belonging to someone else' do
        let(:player) { create :player }

        it 'they cannot view the player' do
          expect {
            get :show, id: player.id
          }.to raise_error(CanCan::AccessDenied)
        end

        it 'they cannot update the player' do
          expect {
            get :edit, id: player.id
          }.to raise_error(CanCan::AccessDenied)

          expect {
            get :update, id: player.id, player: {name: 'test'}
          }.to raise_error(CanCan::AccessDenied)
        end
      end
    end
  end
end
