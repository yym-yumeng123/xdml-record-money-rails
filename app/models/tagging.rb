class Tagging < ApplicationRecord
  belongs_to :record, class_name: "record", foreign_key: "record_id"
  belongs_to :tag, class_name: "tag", foreign_key: "tag_id"
  validates :record_id, :tag_id, presence: true
end
