class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  # validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates_format_of :email, with: /.+@.+/, on: :create, message: "不符合邮箱规格"
  # validates :name, length: { minimum: 2 }
  # validates :bio, length: { maximum: 500 }
  validates :password, length: { in: 6..20 }, on: :create
end
