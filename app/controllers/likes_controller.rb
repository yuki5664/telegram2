class LikesController < ApplicationController
  before_action :set_post

  def like
    like = current_user.likes.new(post_id: @post.id)
    like.save
  end

  def unlike
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
