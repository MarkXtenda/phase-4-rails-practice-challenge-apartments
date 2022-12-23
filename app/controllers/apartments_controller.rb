class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    
        def index
            apartments = Apartment.all
            render json: apartments
        end
    
        def show
            apartment = Apartment.find(params[:id])
            render json: apartment
        end
    
        def update
            apartment = Apartment.find(params[:id])
            if apartment
                updated_apartment = apartment.update!(permited_params)
                render json: apartment
            end
        end
    
        def destroy
            apartment = Apartment.find(params[:id])
            if apartment
                destroyed_apartment = apartment.destroy!
                head :no_content
            end
        end
    
        private 
    
        def permited_params
            params.permit(:number)
        end
    
        def record_not_found
            render json: { "errors": "Not Found"}, status: :not_found
        end
    
        def record_invalid(invalid)
            render json: { "error": invalid.record.errors }, status: 422
        end
end
