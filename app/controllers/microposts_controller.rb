class MicropostsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: :destroy

  def new 
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Sweet! The item has been added to your watch list, and we'll notify you whenever matches are found."
      redirect_to buy_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to buy_path
  end

  private

    def micropost_params
      params.require(:micropost).permit(:keyword, :min, :max, :condition)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end