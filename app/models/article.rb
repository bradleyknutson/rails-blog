require 'elasticsearch/model'

class Article < ApplicationRecord
  include Elasticsearch::Model
  settings index: {} do
    mappings dynamic: 'false' do
      indexes :title
      indexes :body,
      analyzer: 'english',
      index_options: 'offsets'
    end
  end

  def reindex
    IndexJob.perform_async(id)
  end

  after_commit :reindex

  has_many :comments, dependent: :destroy
  has_many :parent_comments, -> { where "parent_comment_id is null" }, class_name: 'Comment'

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: {minimum: 10}
end
