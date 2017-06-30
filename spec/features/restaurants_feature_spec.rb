require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants available'
      expect(page).to have_link 'Add a restaurant'
    end
  end
  
  context 'restaurants have been added' do
    before do
      create_user
      log_in
      @user.restaurants.create_with_user({ name: 'Frankie' }, @user)
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Frankie')
      expect(page).not_to have_content('No restaurants available')
    end
  end

  context 'creating restaurants' do

    before do
      create_user
      log_in
    end

    scenario 'prompts user to fill out a form, then display the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Frankie'
      click_button 'Create restaurant'
      expect(page).to have_content('Frankie')
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do

    before do
      create_user
    end

    let!(:frankie){ @user.restaurants.create_with_user({ name: 'Frankie' }, @user) }

    scenario 'allows a user to view a restaurant' do
      visit '/restaurants'
      click_link 'Frankie'
      expect(page).to have_content('Frankie')
      expect(current_path).to eq "/restaurants/#{frankie.id}"
    end
  end

  context 'editing restaurants' do

    before do
      create_user
      log_in
      @user.restaurants.create_with_user({ name: 'Frankie', description: 'The best hotdogs in Lisbon', id: 1 }, @user)
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Frankie'
      fill_in 'Name', with: 'Frankie Lx'
      fill_in 'Description', with: 'The best hotdogs in Portugal'
      click_button 'Update Restaurant'
      click_link 'Frankie Lx'
      expect(page).to have_content('Frankie Lx')
      expect(page).to have_content('The best hotdogs in Portugal')
      expect(current_path).to eq '/restaurants/1'
    end
  end

  context 'deleting restaurants' do
    before do
      create_user
      log_in
      @user.restaurants.create_with_user({ name: 'KFC', description: 'The best hotwings', id: 2 }, @user)
    end

    scenario 'let a user delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content('KFC')
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'an invalid restaurant' do
    before do
      create_user
      log_in
    end

    scenario 'does not let the user submit a short name' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Fr'
      click_button 'Create restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
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
