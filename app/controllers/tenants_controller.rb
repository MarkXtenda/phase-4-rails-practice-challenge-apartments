class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def update
        tenant = Tenant.find(params[:id])
        if tenant
            updated_tenant = tenant.update!(permited_params)
            render json: tenant
        end
    end

    def destroy
        tenant = Tenant.find(params[:id])
        if tenant
            destroyed_tenant = tenant.destroy!
            head :no_content
        end
    end

    private 

    def permited_params
        params.permit(:name, :age)
    end

    def record_not_found
        render json: { "errors": "Not Found"}, status: :not_found
    end

    def record_invalid(invalid)
        render json: { "error": invalid.record}, status: 422
    end
end
