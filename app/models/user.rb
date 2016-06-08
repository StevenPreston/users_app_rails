class User < ApplicationRecord
  has_many :places
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
