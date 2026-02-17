class City < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :name, presence: true
  validates :zip_code, presence: true
end
