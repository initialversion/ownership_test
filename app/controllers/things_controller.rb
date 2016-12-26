class ThingsController < ApplicationController
  before_action :current_user_must_be_thing_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_thing_user
    thing = Thing.find(params[:id])

    unless current_user == thing.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Thing.ransack(params[:q])
    @things = @q.result(:distinct => true).includes(:user).page(params[:page]).per(10)

    render("things/index.html.erb")
  end

  def show
    @thing = Thing.find(params[:id])

    render("things/show.html.erb")
  end

  def new
    @thing = Thing.new

    render("things/new.html.erb")
  end

  def create
    @thing = Thing.new

    @thing.name = params[:name]
    @thing.user_id = params[:user_id]

    save_status = @thing.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/things/new", "/create_thing"
        redirect_to("/things")
      else
        redirect_back(:fallback_location => "/", :notice => "Thing created successfully.")
      end
    else
      render("things/new.html.erb")
    end
  end

  def edit
    @thing = Thing.find(params[:id])

    render("things/edit.html.erb")
  end

  def update
    @thing = Thing.find(params[:id])

    @thing.name = params[:name]
    @thing.user_id = params[:user_id]

    save_status = @thing.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/things/#{@thing.id}/edit", "/update_thing"
        redirect_to("/things/#{@thing.id}", :notice => "Thing updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Thing updated successfully.")
      end
    else
      render("things/edit.html.erb")
    end
  end

  def destroy
    @thing = Thing.find(params[:id])

    @thing.destroy

    if URI(request.referer).path == "/things/#{@thing.id}"
      redirect_to("/", :notice => "Thing deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Thing deleted.")
    end
  end
end
