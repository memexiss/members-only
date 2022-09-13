class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
  end

  # GET /posts/1 or /posts/1.json
  def show
    @posts = Post.all.order("created_at DESC")
    @users = User.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @posts = Post.all.order("created_at DESC")
  end
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to posts_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
