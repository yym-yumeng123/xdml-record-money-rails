require 'rails_helper'

RSpec.describe Tagging, type: :model do
  context 'create' do
    before :each do
      @user = User.create! email: 'agjgsr@qq.com', password: '123456', password_confirmation: '123456'
    end
    it 'require record' do
      tag = Tag.create! name: 'test'
      tagging = Tagging.create tag: tag
      expect(tagging.errors.details[:record][0][:error]).to eq(:blank)
      expect(tagging.errors[:record][0]).to eq('记录不能为空')
    end
    it 'require tag' do
      record = Record.create! amount: 10000, category: 'outgoings', user: @user
      tagging = Tagging.create record: record
      expect(tagging.errors.details[:tag][0][:error]).to eq(:blank)
      expect(tagging.errors[:tag][0]).to eq('标签不能为空')
    end

    it 'should has record and tag' do

      tag = Tag.create! name: 'test'
      record = Record.create! amount: 10000, category: 'outgoings', user: @user
      tagging = Tagging.create record: record, tag: tag
      expect(tag.records.first.id).to eq record.id
      expect(record.tags.first.id).to eq tag.id
    end

    it 'should has records and tags' do
      tag1 = Tag.create! name: 'test'
      tag2 = Tag.create! name: 'test1'
      record1 = Record.create! amount: 10000, category: 'outgoings', user: @user
      record2 = Record.create! amount: 10000, category: 'outgoings', user: @user
      Tagging.create record: record1, tag: tag1
      Tagging.create record: record2, tag: tag1
      Tagging.create record: record1, tag: tag2
      Tagging.create record: record2, tag: tag2
      expect(tag1.records.count).to eq 2
      expect(tag2.records.count).to eq 2
      expect(record1.tags.count).to eq 2
      expect(record2.tags.count).to eq 2

    end
  end
end