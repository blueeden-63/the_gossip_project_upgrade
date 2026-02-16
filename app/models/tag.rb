class Tag < ApplicationRecord
  has_many :gossip_tags, dependent: :destroy
  has_many :gossips, through: :gossip_tags
end
