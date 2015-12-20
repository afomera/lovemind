class ResourcesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :update, :upvote, :downvote]
  before_action :set_resource, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :set_search_results, only: [:show, :index]


  def index
		@hash = Gmaps4rails.build_markers(@resources) do |resource, marker|
  		marker.lat resource.latitude
  		marker.lng resource.longitude
		end
		respond_to do |format|
	 		format.html {}
	 		format.js { render  "resources/index" }
		end
  end

  def create
  	@resource = current_user.resources.new(resource_params)

    respond_to do |format|
      if @resource.save
				ResourceMailer.submission(@resource).deliver_later
        format.html { redirect_to @resource, notice: "Hey #{current_user.username}, #{@resource.name} was successfully added." }
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
		@comments = @resource.comments.order("created_at DESC")
		@comment = Comment.new
  end

  def upvote
    @resource.upvote_by current_user
    redirect_to :back, notice: "You've upvoted #{@resource.name}, hooray!"
  end

  def downvote
    @resource.downvote_by current_user
    redirect_to :back, notice: "You've downvoted #{@resource.name}, sorry to hear that."
  end

  private

  def resource_params
		params.require(:resource).permit(:name, :address, :phone_number, :notes, :email, :user_id)
  end

   def set_resource
     @resource = Resource.friendly.find(params[:id])
   end

  def set_search_results
    @resources = @search.result(distinct: true)
  end
end
