class User < ApplicationRecord
  belongs_to :city

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  has_many :gossips, dependent: :destroy

has_many :comments, dependent: :destroy
has_many :likes, dependent: :destroy

has_many :sent_private_messages,
class_name: "PrivateMessage",
foreign_key: :sender_id,
dependent: :destroy

has_many :private_message_recipients,
foreign_key: :recipient_id,
dependent: :destroy

has_many :received_private_messages,
through: :private_message_recipients,
source: :private_message
end
