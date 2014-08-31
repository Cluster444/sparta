require 'rails_helper'

RSpec.describe 'Player Registration' do
  context 'when visiting the home page' do
    before { visit root_path }

    it 'has a link to sign up' do
      expect(page).to have_link('Sign Up', new_user_registration_path)
    end

    context 'and following the sign up link' do
      before { click_on 'Sign Up' }

      it 'brings me to the new user registration page' do
        expect(current_path).to eq new_user_registration_path
      end
    end
  end

  context 'when visiting the new user registration page' do
    before { visit new_user_registration_path }

    it 'shows me a sign up form' do
      expect(page).to have_selector('form#new_user')
    end

    context 'and I fill in the form with valid credentials' do
      before do
        within 'form#new_user' do
          fill_in 'Name', with: 'Player'
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_on 'Sign up'
        end
      end

      it 'redirects me to my player show page' do
        expect(current_path).to eq player_path(Player.last)
      end
    end
  end
end
