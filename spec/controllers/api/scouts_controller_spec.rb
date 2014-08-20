require 'rails_helper'

describe Api::ScoutsController do
  render_views

  let!(:player) { create :player }
  let!(:city)   { create :city, player: player }

  describe '#index' do
    it 'provides a list of scouts' do
      scouts = create_list :scout, 2, city: city, player: player

      get :index, player_id: player.id, city_id: city.id, format: 'json'

      scouts_response = JSON.parse(response.body)
      expect(scouts_response.count).to eq 2
      expect(scouts_response[0]).to include({'id' => scouts[1].id})
      expect(scouts_response[1]).to include({'id' => scouts[0].id})
    end
  end

  describe '#show' do
    it 'provides details for a scout' do
      scout = create :scout, player: player, city: city

      get :show, player_id: player.id, city_id: city.id, id: scout.id, format: 'json'

      scout_response = JSON.parse(response.body)
      expect(scout_response).to include({'id' => scout.id})
    end
  end

  describe '#create' do
    it 'allows a scout to be created' do
      scout_attrs = attributes_for :scout

      expect {
        post :create, player_id: player.id, city_id: city.id, scout: scout_attrs, format: 'json'
      }.to change(Scout, :count).by 1

      scout_response = JSON.parse(response.body)
      expect(response.headers).to include('Location' => api_player_city_scout_url(player, city, Scout.last))
      expect(response.status).to eq 201
      expect(scout_response).to include({'id' => Scout.last.id})
    end

    it 'responds with errors when validatiosn fail' do
      post :create, player_id: player.id, city_id: city.id, scout: {food: nil}, format: 'json'

      scout_response = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(scout_response).to have_key 'errors'
      expect(scout_response['errors']).to have_key 'food'
      expect(scout_response['errors']['food']).to eq ["can't be blank", "is not a number"]
    end
  end

  describe '#update' do
    it 'allows a scout to be updated' do
      scout = create :scout, player: player, city: city

      patch :update, player_id: player.id, city_id: city.id, id: scout.id, scout: {food: 999}, format: 'json'

      scout_response = JSON.parse(response.body)
      expect(response.headers).to include('Location' => api_player_city_scout_url(player, city, scout))
      expect(response.status).to eq 200
      expect(scout_response).to include('id' => scout.id, 'food' => 999)
    end

    it 'responds with errors when validations fail' do
      scout = create :scout, player: player, city: city

      patch :update, player_id: player.id, city_id: city.id, id: scout.id, scout: {food: nil}, format: 'json'

      scout_response = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(scout_response).to have_key 'errors'
      expect(scout_response['errors']).to have_key 'food'
      expect(scout_response['errors']['food']).to eq ["can't be blank", "is not a number"]
    end
  end

  describe '#destroy' do
    it 'destroys the scout' do
      scout = create :scout, player: player, city: city

      expect {
        delete :destroy, player_id: player.id, city_id: city.id, id: scout.id, format: 'json'
      }.to change(Scout, :count).by -1

      expect(Scout.find_by(id: scout.id)).to be_nil
      expect(response.body.strip).to eq ''
      expect(response.status).to eq 204
    end
  end
end
