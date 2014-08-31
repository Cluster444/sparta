require 'rails_helper'

RSpec.describe PlayerRegistration do
  let(:player_params) { {name: 'John Smith', email: 'john@smith.com', password: 'password', password_confirmation: 'password'} }

  context 'after initializing' do
    subject { PlayerRegistration.new }

    it 'makes a user object accessible' do
      expect(subject.user).to be_a User
    end

    it 'makes a player object accessible' do
      expect(subject.player).to be_a Player
    end
  end

  context 'when creating a player with valid credentials' do
    subject { PlayerRegistration.new(player_params) }

    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'creates a user record' do
      expect { subject.save }.to change(User, :count).by 1
    end

    it 'creates a player record' do
      expect { subject.save }.to change(Player, :count).by 1
    end

    it 'returns true from save' do
      expect(subject.save).to eq(true)
    end

    it 'relates the player to the user' do
      subject.save
      expect(subject.player.user).to eq(subject.user)
    end
  end

  context 'when creating a player with missing email' do
    subject { PlayerRegistration.new(player_params.merge(email: '')) }

    it 'is invalid' do
      expect(subject).to_not be_valid
    end

    it 'provides an error that the email cant be blank' do
      subject.valid?
      expect(subject.errors[:email]).to eq(["can't be blank"])
    end

    it 'returns false from save' do
      expect(subject.save).to eq(false)
    end
  end

  context 'when creating a player with missing name' do
    subject { PlayerRegistration.new(player_params.merge(name: '')) }

    it 'is invalid' do
      expect(subject).to_not be_valid
    end

    it 'provides an error that the name cant be blank' do
      subject.valid?
      expect(subject.errors[:name]).to eq(["can't be blank"])
    end
  end

  context 'when creating a player with invalid user and player attrs' do
    subject { PlayerRegistration.new(player_params.merge(name: '', email: '')) }

    it 'is invalid' do
      expect(subject).to_not be_valid
    end

    it 'provides an error that email cant be blank' do
      subject.valid?
      expect(subject.errors[:email]).to eq(["can't be blank"])
    end

    it 'provides an error that name cant be blank' do
      subject.valid?
      expect(subject.errors[:name]).to eq(["can't be blank"])
    end
  end
end
