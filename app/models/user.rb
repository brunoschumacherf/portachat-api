# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  enum access_level: { member: 0, admin: 1 }
  enum status: { active: 0, inactive: 1 }

  # Associações
  has_many :room_memberships, dependent: :destroy
  has_many :rooms, through: :room_memberships
  has_many :messages, dependent: :destroy
  # Validações
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }


  def self.ransackable_attributes(auth_object = nil)
    %w[name email]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end
end
