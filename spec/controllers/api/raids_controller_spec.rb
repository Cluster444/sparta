require 'rails_helper'

RSpec.describe Api::RaidsController do
  render_views

  let!(:player) { create :player }
  let!(:city)   { create :city, player: player }

  describe '#index' do
    it 'provides a list of raids' do
      raids = create_list :raid, 2, city: city

      get :index, player_id: player.id, city_id: city.id, format: 'json'

      raids_response = JSON.parse(response.body)
      expect(raids_response.count).to eq 2
      expect(raids_response[0]).to include({'id' => raids[1].id})
      expect(raids_response[1]).to include({'id' => raids[0].id})
    end
  end

  describe '#show' do
    it 'provides details for a raid' do
      raid = create :raid, city: city

      get :show, player_id: player.id, city_id: city.id, id: raid.id, format: 'json'

      raid_response = JSON.parse(response.body)
      expect(raid_response).to include({'id' => raid.id})
    end
  end

  describe '#create' do
    it 'allows a raid to be created' do
      raid_attrs = attributes_for :raid

      expect {
        post :create, player_id: player.id, city_id: city.id, raid: raid_attrs, format: 'json'
      }.to change(Raid, :count).by 1

      raid_response = JSON.parse(response.body)
      expect(response.headers).to include('Location' => api_player_city_raid_url(player, city, Raid.last))
      expect(response.status).to eq 201
      expect(raid_response).to include({'id' => Raid.last.id})
    end

    it 'responds with errors when validatiosn fail' do
      post :create, player_id: player.id, city_id: city.id, raid: {food: nil}, format: 'json'

      raid_response = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(raid_response).to have_key 'errors'
      expect(raid_response['errors']).to have_key 'food'
      expect(raid_response['errors']['food']).to eq ["can't be blank", "is not a number"]
    end
  end

  describe '#update' do
    it 'allows a raid to be updated' do
      raid = create :raid, city: city

      patch :update, player_id: player.id, city_id: city.id, id: raid.id, raid: {food: 999}, format: 'json'

      raid_response = JSON.parse(response.body)
      expect(response.headers).to include('Location' => api_player_city_raid_url(player, city, raid))
      expect(response.status).to eq 200
      expect(raid_response).to include('id' => raid.id, 'food' => 999)
    end

    it 'responds with errors when validations fail' do
      raid = create :raid, city: city

      patch :update, player_id: player.id, city_id: city.id, id: raid.id, raid: {food: nil}, format: 'json'

      raid_response = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(raid_response).to have_key 'errors'
      expect(raid_response['errors']).to have_key 'food'
      expect(raid_response['errors']['food']).to eq ["can't be blank", "is not a number"]
    end
  end

  describe '#destroy' do
    it 'destroys the raid' do
      raid = create :raid, city: city

      expect {
        delete :destroy, player_id: player.id, city_id: city.id, id: raid.id, format: 'json'
      }.to change(Raid, :count).by -1

      expect(Raid.find_by(id: raid.id)).to be_nil
      expect(response.body.strip).to eq ''
      expect(response.status).to eq 204
    end
  end
end
