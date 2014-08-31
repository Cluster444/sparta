require 'rails_helper'

RSpec.describe Api::CitiesController do
  render_views
  let!(:player) { create :player }

  describe '#index' do
    it 'provides a list of cities' do
      cities = create_list :city, 2, player: player

      get :index, player_id: player.id, format: 'json'

      cities_response = JSON.parse(response.body)
      expect(cities_response.count).to eq 2
      expect(cities_response[0]).to include({'id' => cities[1].id})
      expect(cities_response[1]).to include({'id' => cities[0].id})
    end
  end

  describe '#show' do
    it 'provides details for a city' do
      city = create :city, player: player

      get :show, player_id: player.id, id: city.id, format: 'json'

      city_response = JSON.parse(response.body)
      expect(city_response).to include({'id' => city.id})
    end
  end

  describe '#create' do
    it 'allows a city to be created' do
      city_attrs = attributes_for :city

      expect {
        post :create, player_id: player.id, city: city_attrs, format: 'json'
      }.to change(City, :count).by 1

      city_response = JSON.parse(response.body)
      expect(response.headers).to include('Location' => api_player_city_url(player, City.last))
      expect(response.status).to eq 201
      expect(city_response).to include({'id' => City.last.id})
    end

    it 'responds with errors when validatiosn fail' do
      post :create, player_id: player.id, city: {name: ''}, format: 'json'

      city_response = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(city_response).to have_key 'errors'
      expect(city_response['errors']).to have_key 'name'
      expect(city_response['errors']['name']).to eq ["can't be blank"]
    end
  end

  describe '#update' do
    it 'allows a city to be updated' do
      city = create :city, player: player

      patch :update, player_id: player.id, id: city.id, city: {name: 'Update 1'}, format: 'json'

      city_response = JSON.parse(response.body)
      expect(response.headers).to include('Location' => api_player_city_url(player, city))
      expect(response.status).to eq 200
      expect(city_response).to include('id' => city.id, 'name' => 'Update 1')
    end

    it 'responds with errors when validations fail' do
      city = create :city, player: player

      patch :update, player_id: player.id, id: city.id, city: {name: ''}, format: 'json'

      city_response = JSON.parse(response.body)
      expect(response.status).to eq 422
      expect(city_response).to have_key 'errors'
      expect(city_response['errors']).to have_key 'name'
      expect(city_response['errors']['name']).to eq ["can't be blank"]
    end
  end

  describe '#destroy' do
    it 'destroys the city' do
      city = create :city, player: player

      expect {
        delete :destroy, player_id: player.id, id: city.id, format: 'json'
      }.to change(City, :count).by -1

      expect(City.find_by(id: city.id)).to be_nil
      expect(response.body.strip).to eq ''
      expect(response.status).to eq 204
    end
  end
end
