require 'rails_helper'

RSpec.describe "Record", type: :request do
  # before :each do
  #   @user = create(:user)
  # end

  context 'create' do
    it "should not create a record before sign in" do
      post '/records', params: {amount: 10000, category: 'outgoings', notes: '请客'}
      expect(response.status).to eq 401
    end

    it "should create a record" do
      sign_in
      # 金额单位为最小单位 分, 防止浮点数不精确 10000分
      # 类型: 支出 outgoings
      post '/records', params: {amount: 10000, category: 'outgoings', notes: '请客'}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body["resources"]["id"]).to be
    end

    it "should not create a record" do
      sign_in
      post '/records', params: {category: 'outgoings', notes: '请客'}
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body["errors"]["amount"][0]).to eq '金额不能为空'
    end
  end

  context 'destroy' do
    it 'should not destroy a record before sign in' do
      # ! 意思是报错就终止
      record = Record.create amount: 10000, category: 'outgoings', notes: '请客1'
      delete "/records/#{record.id}"
      expect(response.status).to eq 401
    end

    it 'should destroy a record' do
      sign_in
      # record = create :record, user: @user
      record = Record.create amount: 10000, category: 'outgoings', notes: '请客1'
      delete "/records/#{record.id}"
      expect(response.status).to eq 200
    end
  end

  # # 获取所有 index
  # context 'index' do
  #   it 'should not get a record before sign_in' do
  #     get '/records'
  #     expect(response.status).to eq 401
  #   end

  #   it 'should get records' do
  #     (1..20).to_a.map do
  #       create :record, user: @user
  #     end
  #     sign_in
  #     get '/records'
  #     expect(response.status).to eq 200
  #     body = JSON.parse response.body
  #     expect(body['resources'].length).to eq 10
  #   end
  # end

  # # 获取一个 show
  # context 'show' do
  #   it 'should not get a record before sign_in' do
  #     record =create :record, user: @user
  #     get "/records/#{record.id}"
  #     expect(response.status).to eq 401
  #   end

  #   it 'should get a record' do
  #     sign_in
  #     record = create :record, user: @user
  #     get "/records/#{record.id}"
  #     expect(response.status).to eq 200
  #   end

  #   it 'should get a record because not found' do
  #     sign_in
  #     get "/records/9999999"
  #     expect(response.status).to eq 404
  #   end
  # end

  # context 'update' do
  #   it 'should not update a record before sign in' do
  #     record = create :record, user: @user
  #     patch "/records/#{record.id}", params: {amount: 9900}
  #     expect(response.status).to eq 401
  #   end

  #   it 'should update a record' do
  #     sign_in
  #     record = create :record, user: @user
  #     patch "/records/#{record.id}", params: {amount: 9900}
  #     expect(response.status).to eq 200
  #     body = JSON.parse response.body
  #     expect(body["resource"]["amount"]).to eq 9900
  #   end
  # end
end