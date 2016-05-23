class StaticPagesController < ApplicationController
  def new
  end

  def home
    @entry = current_user.entries.build if logged_in?
    @feed_items = current_user.feed.paginate(page:params[:page])
  end

  def help
  end

  def about
  end
end
