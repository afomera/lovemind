class ResourcesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :update, :upvote, :downvote]
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  

  def index
  	@resource = Resource.all
  end

  def create
  	@resource = current_user.resources.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: "Hey #{current_user.email}, #{@resource.name} was successfully added." }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
  	@resource = Resource.new
  end

  def update
  end

  def show
  end

  def upvote
    @resource.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @resource.downvote_by current_user
    redirect_to :back
  end

  private

  def resource_params
	params.require(:resource).permit(:name, :address, :phone_number, :notes, :user_id)
  end

   def set_resource
     @resource = Resource.friendly.find(params[:id])
   end

end
