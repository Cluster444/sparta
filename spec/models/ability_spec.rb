require 'spec_helper'

RSpec.describe Ability do
  context 'when authenticated as a user' do
    let(:user) { stub_model(User) }
    subject { Ability.new(user) }
    it { is_expected.not_to be_able_to(:manage, :all) }

    it { is_expected.not_to be_able_to(:index, Player) }
    it { is_expected.not_to be_able_to(:create, Player) }
    it { is_expected.to be_able_to(:create, City) }
    it { is_expected.to be_able_to(:create, Raid) }
    it { is_expected.to be_able_to(:create, Scout) }

    context 'accessing resources that are mine' do
      let(:player) { stub_model(Player, user_id: user.id, user: user) }
      let(:city) { stub_model(City, player_id: player.id, player: player) }
      let(:raid) { stub_model(Raid, city_id: city.id, city: city) }
      let(:scout) { stub_model(Scout, city_id: city.id, city: city) }

      it { is_expected.to be_able_to(:show, player) }
      it { is_expected.to be_able_to(:edit, player) }
      it { is_expected.not_to be_able_to(:destroy, player) }

      it { is_expected.to be_able_to(:read, city) }
      it { is_expected.to be_able_to(:update, city) }
      it { is_expected.to be_able_to(:destroy, city) }

      it { is_expected.to be_able_to(:read, raid) }
      it { is_expected.to be_able_to(:update, raid) }
      it { is_expected.to be_able_to(:destroy, raid) }

      it { is_expected.to be_able_to(:read, scout) }
      it { is_expected.to be_able_to(:update, scout) }
      it { is_expected.to be_able_to(:destroy, scout) }
    end

    context 'accessing resources that are not mine' do
      let(:player) { stub_model(Player, user_id: user.id, user: user) }
      let(:other_player) { stub_model(Player) }
      let(:city) { stub_model(City, player_id: other_player.id, player: other_player) }
      let(:raid) { stub_model(Raid, city_id: city.id, city: city) }
      let(:scout) { stub_model(Scout, city_id: city.id, city: city) }

      it { is_expected.not_to be_able_to(:read, other_player) }
      it { is_expected.not_to be_able_to(:update, other_player) }
      it { is_expected.not_to be_able_to(:destroy, other_player) }

      it { is_expected.not_to be_able_to(:read, city) }
      it { is_expected.not_to be_able_to(:update, city) }
      it { is_expected.not_to be_able_to(:destroy, city) }

      it { is_expected.not_to be_able_to(:read, raid) }
      it { is_expected.not_to be_able_to(:update, raid) }
      it { is_expected.not_to be_able_to(:destroy, raid) }

      it { is_expected.not_to be_able_to(:read, scout) }
      it { is_expected.not_to be_able_to(:update, scout) }
      it { is_expected.not_to be_able_to(:destroy, scout) }
    end
  end
end
