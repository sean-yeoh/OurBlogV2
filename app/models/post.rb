class Post < ApplicationRecord
  belongs_to :admin
  validates :title, presence: true
  validates :content, presence: true
  default_scope { order(id: :desc) }
end
