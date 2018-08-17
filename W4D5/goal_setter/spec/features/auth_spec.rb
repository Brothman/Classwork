
require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content("username", "password")
  end


  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in('username', with: 'testing_username')
      fill_in('password', with: 'testing_password')
    end
    scenario 'shows username on the homepage after signup' do
      save_and_open_page
      click_on 'Sign up'
      # save_and_open_page
      expect(page).to have_content("testing_username")
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login'

end

feature 'logging out' do
  scenario 'begins with a logged out state'

  scenario 'doesn\'t show username on the homepage after logout'

end
