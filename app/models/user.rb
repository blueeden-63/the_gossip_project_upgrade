class User < ApplicationRecord
belongs_to :city

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
