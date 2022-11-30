require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Taggings" do
  let(:user){User.create! email: 'agjgsr@qq.com', password: '123456', password_confirmation: '123456'}
  let(:tag){Tag.create! name: '饮食'}
  let(:tag_id){tag.id}
  let(:record_id){record.id}
  let(:record){Record.create! amount: 10000, category: 'income', user: user}
  let(:tagging){Tagging.create! tag: tag, record: record}
  let(:id){tagging.id}
  let(:taggings){
    (1..10).to_a.map do |i|
      Tagging.create! record: record, tag: Tag.create!(name: "test#{i}")
    end
  }

  let(:create_taggings){
    tagging
    taggings
    nil
  }

  post "/taggings" do
    parameter :tag_id, '标签ID', type: :number, required: true
    parameter :record_id, '记录ID', type: :number, required: true
    example "创建标记" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  delete "/taggings/:id" do
    example "删除标记" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/taggings" do
    parameter :page, '页码', type: :integer

    let(:page) {1}
    example '获取所有标记' do
      create_taggings
      sign_in
      do_request
      expect(status).to eq 200
      body = JSON.parse response_body
      expect(body['resources'].length).to eq 10
    end

  end

  get "/taggings/:id" do
    example '获取一个标记' do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end
end