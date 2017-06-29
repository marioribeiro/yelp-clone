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
      Restaurant.create(name: 'Frankie')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Frankie')
      expect(page).not_to have_content('No restaurants available')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then display the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Frankie'
      click_button 'Create restaurant'
      expect(page).to have_content('Frankie')
      expect(current_path).to eq '/restaurants'
    end
  end
end
