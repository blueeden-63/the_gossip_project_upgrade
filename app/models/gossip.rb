class Gossip < ApplicationRecord
  belongs_to :user

  has_many :gossip_tags, dependent: :destroy
  has_many :tags, through: :gossip_tags

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
end
