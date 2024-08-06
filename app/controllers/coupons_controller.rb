class CouponsController < ApplicationController
  before_action :set_merchant
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = @merchant.coupons
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @coupon = @merchant.coupons.new
  end

  def create
    @coupon = @merchant.coupons.new(coupon_params)
    if @merchant.five_coupons_max
      flash[:alert] = "Merchant has 5 Active Coupons already selected"
      render :new
    elsif @coupon.save
      flash[:notice] = "Coupon created successfully"
      redirect_to merchant_coupons_path(@merchant)
    else
      flash[:alert] = @coupon.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def coupon_params
  params.require(:coupon).permit(:name, :code, :discount_type, :discount_amount, :active)
  end 
end