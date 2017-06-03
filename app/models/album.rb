class Album < ApplicationRecord
  belongs_to :admin
  has_many :photos, dependent: :destroy
  validates :name, presence: true
  default_scope { order(id: :desc) }
end
