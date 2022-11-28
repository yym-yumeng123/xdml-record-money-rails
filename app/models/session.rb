class Session
  include ActiveModel::Model

  # 属性访问器
  attr_accessor :email, :password

  validates :email, presence: true
  validates :password, presence: true
  validates_format_of :email, with: /.+@.+/, on: :create, if: :email
  validates :password, length: { in: 6..20 }, if: :password
end