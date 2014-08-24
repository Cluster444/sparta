require 'rails_helper'

RSpec.describe DashboardsController, :type => :controller do
  let(:player) { create :player }

  describe '#raiding' do
    it 'makes a raiding view available for the template' do
      get :raiding, id: player.id

      expect(assigns(:view)).to be_a RaidingView
    end

    context 'when there are no cities' do
      it 'then @cities is empty' do
        get :raiding, id: player.id

        expect(assigns(:cities)).to be_empty
      end
    end

    context 'when there are cities that belong to the current player' do
      let!(:cities) { create_list :city, 2, player: player }

      it 'then @cities contains the players cities' do
        get :raiding, id: player.id

        expect(assigns(:cities)).to contain_exactly(*cities)
      end

      context 'and cities that belong to other players' do
        it 'then @cities contains only the current players cities' do
          other_player = create :player
          other_cities = create_list :city, 2, player: other_player

          get :raiding, id: player.id

          expect(assigns(:cities)).to contain_exactly(*cities)
        end
      end
    end
  end
end
