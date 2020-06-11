class SchedulesController < ApplicationController

before_action :require_user_logged_in
before_action :correct_user, only: [:edit,:update,:destroy]

    def new
        @trip = current_user.trips.find(params[:id])
        @schedule = @trip.schedules.new
    end

    def create
        @trip = current_user.trips.find(params[:id])
        @schedule = @trip.schedules.new(schudule_params)
        if @schedule.save
            flash[:success] = '登録しました。'
            redirect_to @trip
        else
            flash.now[:danger] = '登録に失敗しました。'
            render :new
        end
    end

    def edit
        @schedule = Schedule.find(params[:id])
    end

    def update
        @schedule = Schedule.find(params[:id])
        if @schedule.update(schudule_params)
            @trip = Trip.find(@schedule.trip_id)
            flash[:success] = '更新しました。'
            redirect_to @trip
        else
            flash.now[:danger] = '更新に失敗しました。'
            render :edit
        end
    end

    def destroy
        @schedule = Schedule.find(params[:id])
        @schedule.destroy
        redirect_back(fallback_location: root_path)
        flash[:success] = '削除しました。'
    end

    private
        
    def schudule_params
        params.require(:schedule).permit(:event,:date,:departure_time,:departure_place,:arrival_time,:arrival_place,:price)
    end
    
    def correct_user
        @schedule = Schedule.find_by(id: params[:id])
        unless @schedule
            redirect_to root_path
        end
    end
    
end