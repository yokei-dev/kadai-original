class TripsController < ApplicationController
  

  def show
    @trip = current_user.trips.find_by(id: params[:id])
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
        @trip.image_name = "defalut.png"
      end
    if @trip.save
      redirect_to current_user
      flash[:success] = '投稿しました。'
    else
      render :new
      flash[:danger] = '投稿に失敗しました。'
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
        @trip.image_name = "defalut.png"
      end
      if @trip.save
        redirect_to current_user
        flash[:success] = '更新しました。'
      else
        render :edit
        flash[:danger] = '更新に失敗しました。'
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
  
  
  
end
