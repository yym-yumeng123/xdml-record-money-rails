class Tagging < ApplicationRecord
  belongs_to :record
  belongs_to :tag
  validates :record_id, :tag_id, presence: true
end
