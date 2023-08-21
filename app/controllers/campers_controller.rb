class CampersController < ApplicationController

    def index
        campers = Camper.all
        render json: campers, except: excluded_attributes, status: :ok
    end

    def show
        camper = find_camper_by_id
        if camper
            render json: camper.as_json(
                except: excluded_attributes,
                include: {activities: {except: excluded_attributes}}
            ), status: :ok
        else
            render json: {error: "Camper not found"}, status: :not_found
        end
    end

    def create
        camper = Camper.create(camper_params)
        if camper.valid?
            render json: camper, except: excluded_attributes, status: :created
        else
            render json: {error: camper.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def find_camper_by_id
        Camper.find_by(id: params[:id])
    end

    def excluded_attributes
        [:created_at, :updated_at]
    end
end
