class Post < ApplicationRecord
  belongs_to :admin
  validates :title, presence: true
  validates :content, presence: true
  default_scope { order(id: :desc) }

  def previous
    Post.where(["id < ?", id]).first
  end

  def next
    Post.where(["id > ?", id]).last
  end
end
