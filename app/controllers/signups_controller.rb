class SignupsController < ApplicationController
    def create
        signup = Signup.create(signup_params)
        if signup.valid?
            render json: signup.activity, except: excluded_attributes, status: :created
        else
            render json: {error: signup.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private
    def excluded_attributes
        [:created_at, :updated_at]
    end

    def signup_params
        params.permit(:time, :activity_id, :camper_id)
    end
end
