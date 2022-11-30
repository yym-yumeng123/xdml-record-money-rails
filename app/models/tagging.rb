class Tagging < ApplicationRecord
  belongs_to :record, required: true
  belongs_to :tag, required: true
  belongs_to :user  # validates :record_id, :tag_id, presence: true
end
