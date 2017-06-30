require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  it { should belong_to(:user) }

  before do
      @user = User.create(email: 'test@user.com', password: 'abc12345')
    end

  it 'is not valid with a name of less than three characters' do
    restaurant = @user.restaurants.create_with_user({ name: 'Fr' }, @user)
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    @user.restaurants.create_with_user({name: 'Lupita'}, @user)
    restaurant = @user.restaurants.create_with_user({name: 'Lupita'}, @user)
    expect(restaurant).to have(1).error_on(:name)
  end
end
