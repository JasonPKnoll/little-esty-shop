class Merchant::DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def new
  end

  def create
    @discount = Discount.new(discount_params)
    if @discount.save
      redirect_to merchant_discounts_path
      flash[:success] = "Success: New discount has been created!"
    end
  end

  private

  def discount_params
    params.permit(:id, :percentage, :threshold, :merchant_id)
  end
end
