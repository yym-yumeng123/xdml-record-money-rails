class Session
  include ActiveModel::Model

  # 属性访问器
  attr_accessor :email, :password, :user

  validates :email, presence: true
  validate :check_email, if: :email
  validates :password, presence: true

  validates_format_of :email, with: /.+@.+/, on: :create, if: :email
  validates :password, length: { in: 6..20 }, if: :password
  validate :email_password_match, if: Proc.new { |s| s.email.present? and s.password.present? }

  # 自定义校验 邮箱是否存在
  def check_email
    @user ||= User.find_by_email email
    if user.nil?
      errors.add :email, :not_found
    end
  end
  
  def email_password_match
    @user ||= User.find_by_email email
    if user and not user.authenticate(password)
      errors.add :password, :mismatch
    end
  end
end