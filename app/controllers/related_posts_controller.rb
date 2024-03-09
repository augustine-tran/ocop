# frozen_string_literal: true

class RelatedPostsController < ApplicationController
  layout 'posts'

  def index
    @posts = Post.all.active.limit 3
  end
end
