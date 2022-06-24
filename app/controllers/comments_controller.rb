class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])

    comment_data = comment_params
    comment_data[:user_id] =  current_user.id

    @comment = @article.comments.create(comment_data)
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_comment_id)
    end
end
