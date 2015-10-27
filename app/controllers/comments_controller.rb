class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.resource = Resource.friendly.find(params[:resource_id])
    @resource = Resource.friendly.find(params[:resource_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @resource, notice: "Hey #{current_user.username}, your comment was successfully added." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

private
def comment_params
  params.require(:comment).permit(:body, :resource_id, :user_id)
end
end
