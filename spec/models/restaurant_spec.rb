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

  describe 'reviews' do

    describe 'build_with_user' do

      let(:user) { User.create email: 'test@test.com' }
      let(:restaurant) { Restaurant.create name: 'Test' }
      let(:review_params) { {rating: 5, thoughts: 'yum'} }
      subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

      it 'builds a review' do
        expect(review).to be_a Review
      end

      it 'builds a review associated with the specified user' do
        expect(review.user).to eq user
      end
    end
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = @user.restaurants.create_with_user({name: 'The Ivy'}, @user)
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns the rating' do
        restaurant = @user.restaurants.create_with_user({name: 'The Ivy'}, @user)
        restaurant.reviews.create_with_user({ rating: 4 }, @user)
        expect(restaurant.average_rating).to eq 4
      end
    end
  end
end
