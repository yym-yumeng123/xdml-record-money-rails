class User < ApplicationRecord
  has_secure_password
  has_many :records
  has_many :tags
  has_many :taggings

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password_confirmation, presence: true, on: :create
  validates_format_of :email, with: /.+@.+/, on: :create, if: Proc.new { |u| u.email.present? }
  validates :password, length: { in: 6..20 }, on: :create, if: :password

  after_create :send_welcome_mail

  def send_welcome_mail
    UserMailer.welcome_email(self).deliver_later
  end
end
