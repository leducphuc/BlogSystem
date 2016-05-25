class StaticPagesController < ApplicationController
  def new
  end

  def home
    if logged_in?
    @entry = current_user.entries.build
    @feed_items = current_user.feed.paginate(page:params[:page])
    @comment = Comment.new
    else
      @feed_items = Entry.all.paginate(page:params[:page])
    end
  end

  def help
  end

  def about
  end
end
