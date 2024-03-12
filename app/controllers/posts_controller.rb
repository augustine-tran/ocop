# frozen_string_literal: true

class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_post, only: %i[show]

  def index
    @posts = Post.ordered_active.limit 10
  end

  def show; end

  private

  def set_post
    @post = Post.find_by(slug: params[:id])
  end
end
