require 'rails_helper'

describe PlacesController do
  describe 'GET #index' do
    let(:user) { FactoryGirl.create(:user_with_places) }

    it 'assigns user to @user' do
      get :index, params: { user_id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the users places to @places' do
      get :index, params: { user_id: user.id }
      expect(assigns(:places)).to eq(user.places)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryGirl.create(:user) }

    let(:valid_params) {
      {
        place: {
          name: 'The Plaza Hotel',
          formatted_address: '5th Avenue, New York, NY, 10000'
        },
        user_id: user.id
      }
    }

    it 'assigns user to @user' do
      post :create, params: valid_params
      expect(assigns(:user)).to eq(user)
    end

    it 'creates a new place' do
      expect{ post :create, params: valid_params }.to change(Place, :count).by(1)
    end

    it 'creates a new place owned by the user' do
      expect{ post :create, params: valid_params }.to change(user.places, :count).by(1)
    end
    
    it 'redirects to user places' do
      post :create, params: valid_params
      expect(response).to redirect_to user_places_url
    end
  end
end
