require 'rails_helper'

feature 'reviewing' do
  before do
    create_user
    log_in
    @user.restaurants.create_with_user({ name: 'Frankie' }, @user)
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Frankie'
    fill_in 'Thoughts', with: 'Amazing'
    select '5', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Amazing')
  end

  # Helpers

  def create_user
    @user = User.create(email: 'test@user.com', password: 'abc12345')
  end

  def log_in
    visit '/restaurants'
    click_link 'Sign in'
    fill_in 'Email', with: 'test@user.com'
    fill_in 'Password', with: 'abc12345'
    click_button 'Log in'
  end

end
