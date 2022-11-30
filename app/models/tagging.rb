class Tagging < ApplicationRecord
  belongs_to :record, required: true
  belongs_to :tag, required: true
  # validates :record_id, :tag_id, presence: true
end
