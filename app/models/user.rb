class User < ApplicationRecord
  include WithUserAssociationExtension

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :restaurants, -> { extending WithUserAssociationExtension },
  dependent: :destroy
  
end
