class MainController < ApplicationController
  before_action :set_user, only: [:update]
  before_action :set_poker_tables, only: [:poker_tables]

  def index
  end

  # put /update
  # put /update.json
  def update
    if @user.update_with_merging(user_params)
      render json: { notice: 'Poker tables were successfully added.' }
    else
      render json: { alert: 'Could not update user', errors: @user.errors.full_messages }, status: 422
    end
  end

  def poker_tables
    render json: @poker_tables
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
