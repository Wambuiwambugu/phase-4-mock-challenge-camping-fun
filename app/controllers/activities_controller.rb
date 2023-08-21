class ActivitiesController < ApplicationController
    def index
        activities = Activity.all
        render json: activities, except: excluded_attributes, status: :ok
    end

    def destroy
        activity = Activity.find_by(id: params[:id])
        if activity
            activity.destroy
            head :no_content
        else
            render json: {error: "Activity not found"}
        end
    end

    private
    def excluded_attributes
        [:created_at, :updated_at]
    end
end
