class CommentsController < ApplicationController

  before_action :authorize, only: [:create, :up, :down] #LOL
  before_action :find_post

  def new
    @post
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @comment = @post.comments.build(params[:comment].permit(:body, :parent_id))
    @comment.user = current_user
    if @comment.save
      CommentMail.new_comment(current_user, @post).deliver #TODO send in a thread
      redirect_to @post
    else
      redirect_to @post
    end
  end

  def up
    @comment = Comment.find(params[:id])
    @comment.up_vote(current_user)
    CommentMail.new_up_vote(current_user, @comment)
  end

  def down
    @comment = Comment.find(params[:id])
    @comment.down_vote(current_user)
    CommentMail.new_down_vote(current_user, @comment)
  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end
end
