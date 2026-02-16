class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: "User"

  has_many :private_message_recipients, dependent: :destroy
  has_many :recipients, through: :private_message_recipients, source: :recipient

end
