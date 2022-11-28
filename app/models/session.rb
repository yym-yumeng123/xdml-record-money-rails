class Session
  include ActiveModel::Model

  # 属性访问器
  attr_accessor :email, :password

  validates :email, presence: true
  validate :check_email, if: :email
  validates :password, presence: true

  validates_format_of :email, with: /.+@.+/, on: :create, if: :email
  validates :password, length: { in: 6..20 }, if: :password

  # 自定义校验
  def check_email
    user = User.find_by_email email
    if user.nil?
      errors.add :email, :not_found
    end

  end
  
end