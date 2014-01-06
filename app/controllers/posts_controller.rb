class PostsController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
	def index
    @posts = Post.all
	end

	def new
    @post = Post.new
	end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to @post
  end

  def update
    @post = Post.find(params[:id])
   
    if @post.update(params[:post].permit(:title, :text))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
   
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

	def show
	  @post = Post.find(params[:id])
	end

	private
	  def post_params
	    params.require(:post).permit(:title, :text)
	  end
end
