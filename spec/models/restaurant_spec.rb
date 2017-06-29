require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.create(name: 'Fr')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: 'Lupita')
    restaurant = Restaurant.new(name: 'Lupita')
    expect(restaurant).to have(1).error_on(:name)
  end
end
