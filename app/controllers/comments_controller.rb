class CommentsController < ApplicationController
  before_action :logged_in_user,only: [:create,:destroy]
  before_action :correct_user,only: :destroy
  before_action :correct_comment,only: :create
 def create
    @entry = Entry.find(params[:entry_id])
    @comment = current_user.comments.build(content: comment_params[:content],
        entry_id: @entry.id)
    if @comment.save
      @entry.touch
      redirect_to root_url
    else
      redirect_to root_url
    end
 end

  def destroy

  end

	private

		def comment_params
			params.require(:comment).permit(:content)
		end

    def correct_user
      @comments = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comments.nil?
    end

     def correct_comment
       @entry = Entry.find(params[:entry_id])
        redirect_to root_url unless @entry.user == current_user or @entry.user.followers.include?(current_user) 
    end

end
