require 'rails_helper'

RSpec.describe CitiesController do
  let(:authenticatable) { stub_model(User) }

  it_behaves_like 'an authenticated controller', {
    index: [:get, {player_id: 1}],
    show: [:get, {player_id: 1, id: 1}],
    new: [:get, {player_id: 1}],
    edit: [:get, {player_id: 1, id: 1}],
    create: [:post, {player_id: 1}],
    update: [:patch, {player_id: 1, id: 1}],
    destroy: [:delete, {player_id: 1, id: 1}]
  }
end
