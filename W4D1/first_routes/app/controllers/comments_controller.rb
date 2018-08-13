class CommentsController < ApplicationController

  def index
    unless comment_params[:author_id] || comment_params[:artwork_id]
      render json: 'Missing author id or artwork id'
      return
    end

    if comment_params[:author_id]
      comment = Comment.find_by(author_id: comment_params[:author_id])
      if comment
        render json: comment
      else
        render json: 'author_id invalid'
      end
    else
      comment = Comment.find_by(artwork_id: comment_params[:artwork_id])
      if comment
        render json: comment
      else
        render json: 'artwork_id invalid'
      end
    end
  end

  def create
    comment = Comment.create(comment_params)
    if comment
      render json: comment
    else
      render json: comment.errors.full_messages
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    if comment
      comment.destroy
      render json: comment
    else
      render json: 'comment doesn''t exist'
    end
  end

  private

  def comment_params
    begin
      params.require(:comment).permit(:author_id, :artwork_id, :body)
    rescue
      return params
    end
  end

end
