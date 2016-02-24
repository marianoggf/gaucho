require_dependency "gaucho/application_controller"

module Gaucho
  class CustomerCaMovementsController < ApplicationController
    before_action :set_customer_ca_movement, only: [:show, :edit, :update, :destroy]

    # GET /customer_ca_movements
    def index
      @customer_ca_movements = CustomerCaMovement.all
    end

    # GET /customer_ca_movements/1
    def show
    end

    # GET /customer_ca_movements/new
    def new
      @customer_ca_movement = CustomerCaMovement.new
    end

    # GET /customer_ca_movements/1/edit
    def edit
    end

    # POST /customer_ca_movements
    def create
      @customer_ca_movement = CustomerCaMovement.new(customer_ca_movement_params)

      if @customer_ca_movement.save
        redirect_to @customer_ca_movement, notice: 'Customer ca movement was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /customer_ca_movements/1
    def update
      if @customer_ca_movement.update(customer_ca_movement_params)
        redirect_to @customer_ca_movement, notice: 'Customer ca movement was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /customer_ca_movements/1
    def destroy
      @customer_ca_movement.destroy
      redirect_to customer_ca_movements_url, notice: 'Customer ca movement was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer_ca_movement
        @customer_ca_movement = CustomerCaMovement.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def customer_ca_movement_params
        params.require(:customer_ca_movement).permit(:amount, :previous_balance, :date, :customer_id, :customer_ca_movement_type_id)
      end
  end
end
