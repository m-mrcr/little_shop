class Profile::AddressesController < ApplicationController
  before_action :require_reguser

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.create(address_params)
    if @address.save
      flash[:message] = "#{@address.nickname} has been added"
      redirect_to profile_path
    else
      flash[:message] = @address.errors.full_messages
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:message] = "#{@address.nickname} has been updated"
      redirect_to profile_path
    else
      flash[:message] = @address.errors.full_messages
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address && @address.user == current_user
      if @address.restricted?
        flash[:message] = "This address cannot be deleted due to its inclusion in a previous order."
      else
        @address.destroy
      end
      redirect_to profile_path
    end
  end

  private

  def address_params
    params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  end

end
