require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update_user' do
    fixtures :all

    it 'adds new user without tables if it\'s not created' do
      user = { email: 'new_user@mail.ru' }
      put :update_user, user: user
      expect(response).to have_http_status(:success)
      expect(User.find_by_email(user[:email])).not_to eq nil
    end

    it 'adds new user with tables if it\'s not created' do
      user = {
          email: 'new_user@mail.ru',
          poker_table_ids: [poker_tables(:available).id, poker_tables(:available_2).id]
      }
      put :update_user, user: user
      expect(response).to have_http_status(:success)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to match_array user[:poker_table_ids]
    end

    it 'updates user without tables' do
      user = users(:user_without_tables)
      user = { email: user.email }
      put :update_user, user: user
      expect(response).to have_http_status(:success)
      expect(User.find_by_email(user[:email])).not_to eq nil
    end

    it 'adds tables to user without tables' do
      user = users(:user_without_tables)
      user = {
          email: user.email,
          poker_table_ids: [poker_tables(:available).id, poker_tables(:available_2).id]
      }
      put :update_user, user: user
      expect(response).to have_http_status(:success)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to match_array user[:poker_table_ids]
    end

    it 'updates user with tables' do
      user = users(:user_with_tables)
      user = { email: user.email }
      put :update_user, user: user
      expect(response).to have_http_status(:success)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids.size).to be > 0
    end

    it 'adds tables to user with tables' do
      user = users(:user_with_tables)
      user = {
          email: user.email,
          poker_table_ids: [ poker_tables(:available_2).id ]
      }

      old_ids = User.find_by_email(user[:email]).poker_table_ids

      put :update_user, user: user
      expect(response).to have_http_status(:success)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to match_array user[:poker_table_ids] | old_ids
    end

    it 'should not add unavailable tables' do
      user = users(:user_without_tables)
      user = {
          email: user.email,
          poker_table_ids: [poker_tables(:unavailable).id]
      }
      put :update_user, user: user
      expect(response).to have_http_status(422)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to be_empty
    end

    it 'should not add intersected tables to user without tables' do
      user = users(:user_without_tables)
      user = {
          email: user.email,
          poker_table_ids: [poker_tables(:intersected).id, poker_tables(:intersected_2).id]
      }
      put :update_user, user: user
      expect(response).to have_http_status(422)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to be_empty
    end

    it 'should not add intersected tables to user with tables' do
      user = users(:user_with_tables)
      user = {
          email: user.email,
          poker_table_ids: [poker_tables(:intersected).id, poker_tables(:intersected_2).id]
      }
      old_ids = User.find_by_email(user[:email]).poker_table_ids
      put :update_user, user: user
      expect(response).to have_http_status(422)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to match_array old_ids
    end

    it 'should not add intersected tables to user with intersected table' do
      user = users(:user_with_intersected_table)
      user = {
          email: user.email,
          poker_table_ids: [poker_tables(:intersected_2).id]
      }
      old_ids = User.find_by_email(user[:email]).poker_table_ids
      put :update_user, user: user
      expect(response).to have_http_status(422)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to match_array old_ids
    end

    it 'should add available table to user with unavailable table' do
      user = users(:user_with_unavailable_table)
      user = {
          email: user.email,
          poker_table_ids: [ poker_tables(:available).id ]
      }

      old_ids = User.find_by_email(user[:email]).poker_table_ids

      put :update_user, user: user
      expect(response).to have_http_status(:success)
      persisted_user = User.find_by_email(user[:email])
      expect(persisted_user).not_to eq nil
      expect(persisted_user.poker_table_ids).to match_array user[:poker_table_ids] | old_ids
    end
  end

  describe 'GET #poker_tables' do
    fixtures :all

    it 'returns http success' do
      get :poker_tables
      expect(response).to have_http_status(:success)
    end

    it 'returns available poker tables' do
      get :poker_tables
      result = JSON.parse(response.body)
      expect(result).to include poker_tables(:available).as_json
    end

    it 'returns only available poker tables' do
      get :poker_tables
      result = JSON.parse(response.body)
      result.each { |table| expect(table['start_time']).to be > Time.now }
    end

    it 'returns all available tables' do
      get :poker_tables
      result = JSON.parse(response.body)
      expect(result.size).to eq PokerTable.available.count
    end
  end
end
