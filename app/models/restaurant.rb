class Restaurant < ApplicationRecord
  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true
  has_many :reviews, dependent: :destroy
end
