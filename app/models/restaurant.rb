class Restaurant < ApplicationRecord
  include WithUserAssociationExtension

  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true
  
end
