class User < ApplicationRecord
  include WithUserAssociationExtension

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restaurants, -> { extending WithUserAssociationExtension },
  dependent: :destroy
  has_many :reviews
  has_many :reviewed_restaurants, through: :reviews, source: :restaurant

  def has_reviewed?(restaurant)
    reviewed_restaurants.include? restaurant
  end
  
end
