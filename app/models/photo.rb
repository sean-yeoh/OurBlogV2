class Photo < ApplicationRecord
  include ImageUploader[:image]
  belongs_to :admin
  belongs_to :album
  validates :image, presence: true
  default_scope { order(id: :desc) }
end
