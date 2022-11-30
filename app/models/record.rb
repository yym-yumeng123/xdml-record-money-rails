class Record < ApplicationRecord
  # 我拥有很多从属, 拥有很多 taggings
  has_many :taggings
  # 通过间接关系, 我有很多 tags
  has_many :tags, through: :taggings
  belongs_to :user
  
  enum category: { outgoings: 1, income: 2 }
  validates :amount, presence: true
  validates :category, presence: true
end
