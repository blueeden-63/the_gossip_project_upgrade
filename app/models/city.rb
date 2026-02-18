class City < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :gossips, through: :users

  validates :name, presence: true
  validates :zip_code, presence: true
end
