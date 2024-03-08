# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show]

  def index
    @posts = Post.all.active
  end

  def show; end

  private

  def set_post
    @post = Post.find_by(slug: params[:id])
  end
end
