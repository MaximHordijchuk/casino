class MainController < ApplicationController
  before_action :set_user, only: [:update]
  before_action :set_poker_tables

  def index
    @user = User.new
  end

  def update
    respond_to do |format|
      if @user.update_with_merging(user_params)
        format.html { redirect_to root_path, notice: 'Poker tables were successfully added.' }
      else
        format.html { render :index, alert: 'Could not create user' }
      end
    end
  end

  private

  def set_user
    @user = User.find_or_initialize_by(email: user_params[:email])
  end

  def set_poker_tables
    @poker_tables = PokerTable.available
  end

  def user_params
    params.require(:user).permit(:email, { poker_table_ids: [] })
  end
end
