class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def create 
            created_lease = Lease.create!(permited_params)
            render json: created_lease
    end

    def destroy
        lease = Lease.find(params[:id])
        if lease
            destroyed_lease = lease.destroy!
            head :no_content
        end
    end

    private 
    
    def permited_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end

    def record_not_found
        render json: { "errors": "Not Found"}, status: :not_found
    end

    def record_invalid(invalid)
        render json: { "error": invalid.record.errors }, status: 422
    end
end
