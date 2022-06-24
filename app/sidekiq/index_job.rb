class IndexJob
  include Sidekiq::Job

  def perform(id)
    article = Article.find(id)
    article.__elasticsearch__.index_document
  end
end
