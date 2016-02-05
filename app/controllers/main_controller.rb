class MainController < ApplicationController
  before_action :set_user, only: [:update]

  def index
    @poker_tables = PokerTable.available
  end

  def update
    respond_to do |format|
      if @user.persisted? || @user.save
        add_poker_tables
        format.html { redirect_to '/', notice: 'Poker tables were successfully added.' }
      else
        format.html { redirect_to '/', alert: 'Could not create user' }
      end
    end
  end

  private

  def set_user
    @user = User.find_or_initialize_by(user_params)
  end

  def add_poker_tables
    if !params[:poker_tables].nil? && !params[:poker_tables][:id].nil?
      tables = params[:poker_tables][:id].map { |id, checked| id.to_i if checked == '1' }.flatten
      tables &= PokerTable.available.pluck(:id).to_a
      tables.each { |table_id| @user.poker_tables << PokerTable.find(table_id) }
    end
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
