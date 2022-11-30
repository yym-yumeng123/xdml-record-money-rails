
require 'rails_helper'

RSpec.describe "Tags", type: :request do
  context 'create' do
    it "should not create a tag before sign in" do
      post '/tags', params: {name: '饮食'}
      expect(response.status).to eq 401
    end

    it "should create a tag after sign in" do
      sign_in
      post '/tags', params: {name: '饮食'}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resources']['id']).to be
    end

    it "should not create a tag without name" do
      sign_in
      post '/tags'
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body['errors']['name'][0]).to eq '标签名不能为空'
    end
  end

  context 'destroy' do
    it 'should not destroy a tag before sign in' do
      # ! 意思是报错就终止
      tag = Tag.create! name: 'test'
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end

    it 'should destroy a tag' do
      sign_in
      tag = Tag.create! name: 'test'
      delete "/tags/#{tag.id}"
      expect(response.status).to eq 200
    end
  end

  # 获取所有 index
  context 'index' do
    it 'should not get a tag before sign_in' do
      get '/tags'
      expect(response.status).to eq 401
    end

    it 'should get tags' do
      (1..20).to_a.map do |i|
        Tag.create! name: "test#{i}"
      end
      sign_in
      get '/tags'
      expect(response.status).to eq 200
      body = JSON.parse response.body
      expect(body['resources'].length).to eq 10
    end
  end


  # 获取一个 show
  context 'show' do
    it 'should not get a tag before sign_in' do
      tag = Tag.create! name: 'test'
      get "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end

    it 'should get a tag' do
      sign_in
      tag = Tag.create! name: 'test'
      get "/tags/#{tag.id}"
      expect(response.status).to eq 200
    end

    it 'should get a tag because not found' do
      sign_in
      get "/tags/9999999"
      expect(response.status).to eq 404
    end
  end
  
  # # 更新
  # context 'update' do
  #   it 'should not update a tag before sign in' do
  #     tag = Tag.create! name: 'text'
  #     patch "/tags/#{tag.id}", params: {name: '饮食'}
  #     expect(response.status).to eq 401
  #   end

  #   it 'should update a tag' do
  #     sign_in
  #     tag = Tag.create! name: 'text'
  #     patch "/tags/#{tag.id}", params: {name: '饮食'}
  #     expect(response.status).to eq 200
  #     body = JSON.parse response.body
  #     expect(body["resource"]["name"]).to eq '饮食'
  #   end
  # end
end