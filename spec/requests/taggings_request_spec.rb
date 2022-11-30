require 'rails_helper'

RSpec.describe "Taggings", type: :request do
  before :each do
    @user = User.create! email: 'agjgsr@qq.com', password: '123456', password_confirmation: '123456'
    @record = Record.create! amount: 10000, category: 'income', user: @user
    @tag = Tag.create! name: 'test'
    @tagging = Tagging.create! tag: @tag, record: @record
    (1..10).to_a.map do |i|
      Tagging.create! record: @record, tag: Tag.create!(name: "test#{i}")
    end
  end
  context 'create' do
    it "should not create a tagging before sign in" do
      post '/taggings'
      expect(response.status).to eq 401
    end

    it 'should create a tagging after sign_in' do
      sign_in
      # record = Record.create! amount: 10000, category: 'income'
      # tag = Tag.create! name: 'test'
      post '/taggings', params: {record_id: @record.id, tag_id: @tag.id}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resources']['id']).to be
    end

    it 'should not create a tagging without record_id' do
      sign_in
      # record = Record.create! amount: 10000, category: 'income'
      # tag = Tag.create! name: 'test'
      post '/taggings', params: { tag_id: @tag.id}
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body['errors']['record'][0]).to eq '记录不能为空'
    end
  end

  context 'destroy' do
    it "should not destory a tagging before sign in" do
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end

    it "should destory a tagging after sign in" do
      sign_in
      delete "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end
  end

  context 'index' do
    it 'should not get a taggings before sign_in' do
      get '/taggings'
      expect(response.status).to eq 401
    end

    it 'should get taggings' do
      sign_in
      get '/taggings'
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end

  context 'show' do
    it 'should not get a tagging before sign_in' do
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 401
    end

    it 'should get a tagging' do
      sign_in
      get "/taggings/#{@tagging.id}"
      expect(response.status).to eq 200
    end

    it 'should get a tagging because not found' do
      sign_in
      get "/taggings/9999999"
      expect(response.status).to eq 404
    end
  end
end