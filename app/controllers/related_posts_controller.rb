# frozen_string_literal: true

class RelatedPostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]

  layout 'posts'

  def index
    @posts = Current.account.posts.ordered_active.limit 3
  end
end
