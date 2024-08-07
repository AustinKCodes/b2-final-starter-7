class CouponsController < ApplicationController
  before_action :set_merchant
  before_action :set_coupon, only: [:show, :update]
  def index
    @active_coupons = @merchant.active_coupons
    @inactive_coupons = @merchant.inactive_coupons
  end

  def show
    @coupon = Coupon.find(params[:id])
    @coupon_use_count = @coupon.use_count
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
  
  def update
    if params[:coupon].present?
      if params[:coupon][:active] == "false"
        @coupon.update(active: false)
        flash[:notice] = "Coupon deactivated successfully"
      elsif params[:coupon][:active] == "true"
        @coupon.update(active: true)
        flash[:notice] = "Coupon activated successfully"
      end
      redirect_to merchant_coupon_path(@merchant, @coupon)
    end
  end

  private
  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :code, :discount_type, :discount_amount, :active)
  end 

  def set_coupon
    @coupon = @merchant.coupons.find(params[:id])
  end
end