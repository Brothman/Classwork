class CatRentalRequestsController < ApplicationController
  def new
    render :new
  end

  def create
    crr = CatRentalRequest.create(cat_rental_request_params)
    if crr
      redirect_to cat_url(crr.cat_id)
    else
      render json: "You've created a bad cat request"
    end

  end

  def approve
    crr = CatRentalRequest.find(params[:id])
    crr.approve!
    redirect_to cat_url(crr.cat_id)
  end

  def deny
    crr = CatRentalRequest.find(params[:id])
    crr.deny!
    redirect_to cat_url(crr.cat_id)
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end
