class Merchant::DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayService
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    redirect_to merchant_discount_path(@merchant.id, @discount.id)
  end

  def destroy
    @discount = Discount.find(params[:id])
    @discount.destroy

    redirect_to merchant_discounts_path
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
