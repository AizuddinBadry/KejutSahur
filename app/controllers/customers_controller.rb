class CustomersController < ApplicationController
	def index
		render 'home'
	end

	def store
		@check_customer = Customer.where(phone: params[:phone])
		if @check_customer.exists?
			render json: "Maaf, Anda telah daftar sebelum ini!"
		else
			@customer = Customer.create(customer_params)
			render json: @customer
		end
	end

	def customerphone
		@customer = Customer.all
		 respond_to do |format|
    		format.html { render :text => @customer }
 		 end
	end

	private
	def customer_params
		params.permit(:fullname, :email, :phone)
	end
end
