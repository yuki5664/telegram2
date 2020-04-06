class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @post = Post.new # フォーム用の空のインスタンスを生成する。
  end

  def create
    @post = current_user.posts.new(post_params) # ストロングパラメータを引数に
    if @post.save # saveをしてデータベースに保存する。
      redirect_to @post, notice: '投稿を保存しました' # showページにリダイレクト
    else
      render :new
    end
  end
  
  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params # ストロングパラメータを定義する
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
