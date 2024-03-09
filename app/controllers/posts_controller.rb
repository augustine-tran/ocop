# frozen_string_literal: true

class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :set_post, only: %i[show]

  def index
    @posts = Current.account.posts.ordered_active.limit 10
  end

  def show; end

  private

  def set_post
    @post = Current.account.posts.find_by(slug: params[:id])
  end
end
