require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Records" do
  # let(:user){create(:user, email: 'aekjgsr@qq.com')}
  let(:record){Record.create! amount: 10000, category: 'income'}
  let(:id){record.id}
  let(:amount){10000}
  let(:category){'outgoings'}
  let(:notes){'生活开支'}


  post "/records" do
    parameter :amount, '金额', type: :integer, required: true
    parameter :category, '类型: outgoings: 1|income: 2', type: :integer, required: true
    parameter :notes, '备注', type: :string
    example "创建记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  delete "/records/:id" do
    example "删除记录" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/records" do
    parameter :page, '页码', type: :integer

    let(:page) {1}
    example '获取所有记录' do
      (1..11).to_a.map do
        # , user: user
        Record.create! amount: 10000, category: 'income'
      end
      sign_in
      do_request
      expect(status).to eq 200
    end

  end

  get "/records/:id" do
    example '获取一个的记录' do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  patch "/records/:id" do
    parameter :amount, '金额', type: :integer, required: true
    parameter :category, '类型: outgoings: 1|income: 2', type: :integer, required: true
    parameter :notes, '备注', type: :string
    example '更新一个记录' do
      sign_in
      do_request amount: 9900
      expect(status).to eq 200
    end
  end
end