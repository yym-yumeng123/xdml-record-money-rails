require 'rails_helper'

RSpec.describe User, type: :model do
  it '可以带密码创建' do
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.password_digest).to_not equal '123456'
    expect(user.id).to be_a Numeric  
  end
  
  it '可以删除 user' do
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect {
      User.destroy_by id: user.id
    }.to change { User.count }.by(-1)
  end

  it '创建时必须有 email' do
    user = User.create password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq(:blank)  
  end

  it '创建时 email 是唯一的' do
    User.create! email: '1@qq.com', password: '123456', password_confirmation: '123456'
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:email][0][:error]).to eq(:taken)  
  end

  it '创建之后发欢迎邮件给用户' do
    mailer = spy('mailer')
    allow(UserMailer).to receive(:welcome_email).and_return(mailer)
    User.create! email: '11@qq.com', password: '123456', password_confirmation: '123456'
    expect(UserMailer).to have_received(:welcome_email)
    expect(mailer).to have_received(:deliver_later)
  end
end
