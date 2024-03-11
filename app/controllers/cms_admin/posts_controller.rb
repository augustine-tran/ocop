# frozen_string_literal: true

class CmsAdmin::PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /cms/posts or /cms/posts.json
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).order(updated_at: :desc).per(10)
  end

  # GET /cms/posts/1 or /cms/posts/1.json
  def show; end

  # GET /cms/posts/new
  def new
    @post = Post.new
  end

  # GET /cms/posts/1/edit
  def edit; end

  # POST /cms/posts or /cms/posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to cms_admin_posts_path, notice: t(:create_success, name: Post.model_name.human) }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cms/posts/1 or /cms/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params.except(:files_to_remove))
        remove_photos(post_params[:files_to_remove]) if post_params[:files_to_remove].present?

        format.html { redirect_to cms_admin_posts_path, notice: t(:update_success, name: Post.model_name.human) }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms/posts/1 or /cms/posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to cms_admin_posts_url, notice: t(:destroy_success, name: Post.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :category_id, :status, :body, :source, files: [], files_to_remove: [])
  end

  def remove_photos(files_to_remove)
    @post.files.where(id: files_to_remove).map(&:purge)
  end
end
