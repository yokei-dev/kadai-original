class TripsController < ApplicationController
  
before_action :require_user_logged_in
before_action :correct_user, only: [:edit,:update,:destroy]
  
  def show
    @trip = Trip.find_by(id: params[:id])
  end

  def new
    @trip = current_user.trips.new
  end
  
  def create
    @trip = current_user.trips.new(trip_params)
      if params[:trip][:image]
        @trip.image_name = "#{@trip.user_id}_#{@trip.title}.png"
        image = params[:trip][:image]
        File.binwrite("public/trip_images/#{@trip.image_name}",image.read)
      else
        @trip.image_name = "default.png"
      end
    if @trip.save
      flash[:success] = '投稿しました。'
      redirect_to current_user
    else
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @trip = current_user.trips.find_by(id: params[:id])
  end  
  
  def update
    @trip = current_user.trips.find_by(id: params[:id])
    @trip.update(trip_params)
      if params[:trip][:image]
        @trip.image_name = "#{@trip.user_id}_#{@trip.title}.png"
        image = params[:trip][:image]
        File.binwrite("public/trip_images/#{@trip.image_name}",image.read)
      else
        @trip.image_name = "default.png"
      end
      if @trip.save
        flash[:success] = '更新しました。'
        redirect_to current_user
      else
        flash.now[:danger] = '更新に失敗しました。'
        render :edit
      end
  end
  
  
  def destroy
    @trip = current_user.trips.find_by(id: params[:id])
    @trip.destroy
    redirect_back(fallback_location: root_path)
    flash[:success] = '投稿を削除しました。'
  end
  
  private
  
  def trip_params
    params.require(:trip).permit(:title,:started_at,:finished_at)
  end
  
  
  
  def correct_user
    @trip = current_user.trips.find_by(id: params[:id])
    unless @trip
      redirect_to root_path
    end
  end
  
end
