class SchedulesController < ApplicationController

    def new
        @trip = current_user.trips.find(params[:id])
        @schedule = @trip.schedules.new
    end

    def create
        @trip = current_user.trips.find(params[:id])
        @schedule = @trip.schedules.new(schudule_params)
        if @schedule.save
            redirect_to @trip
            flash[:success] = '登録しました。'
        else
            render :new
            flash[:danger] = '登録に失敗しました。'
        end
    end

    def edit
        @schedule = Schedule.find(params[:id])
    end

    def update
        @schedule = Schedule.find(params[:id])
        if @schedule.update(schudule_params)
            @trip = Trip.find(@schedule.trip_id)
            redirect_to @trip
            flash[:success] = '更新しました。'
        else
            render :edit
            flash[:danger] = '登録に失敗しました。'
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
    
end