require 'rails_helper'

RSpec.describe PlayersController do
  let(:authenticatable) { stub_model(User) }

  it_behaves_like 'an authenticated controller', {
    index: [:get, {}],
    show: [:get, {id: 1}],
    edit: [:get, {id: 1}],
    update: [:patch, {id: 1}],
  }
end
