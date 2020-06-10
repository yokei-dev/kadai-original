class LikesController < ApplicationController
  def create
    trip = Trip.find(params[:trip_id])
    current_user.like(trip)
    flash[:success] = '投稿にいいねをしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    trip = Trip.find(params[:trip_id])
    current_user.unlike(trip)
    flash[:success] = '投稿からいいねを解除しました。'
    redirect_back(fallback_location: root_path)

  end
end
