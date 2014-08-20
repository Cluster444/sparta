require 'rails_helper'

describe Api::PlayersController do
  render_views

  describe '#show' do
    it 'provides details for a player' do
      player_attrs = {'name' => 'John Smith', 'x' => 100, 'y' => -150}
      player = create :player, player_attrs

      get :show, id: player.id, format: 'json'
      player_response = JSON.parse(response.body)
      expect(player_response).to eq({'id' => player.id}.merge(player_attrs))
    end
  end
end
