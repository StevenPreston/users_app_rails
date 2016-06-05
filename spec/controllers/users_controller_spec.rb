require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    context 'when no user is already logged in' do
      it 'assigns new User to @user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'renders new' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when a user is already logged in' do
      include SessionsHelper
      let(:user) { FactoryGirl.create(:user) }
      it 'redirects to the current user' do
        log_in user
        get :new
        expect(response).to redirect_to user_url(user)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_params) {
        {
          user: {
            email: 'test@example.com', password: 'password'
          } 
        }
      }

      it 'creates a new user' do
        expect{ post :create, params: valid_params }.to change(User, :count).by(1)
      end

      it 'logs the user in' do
        post :create, params: valid_params
        expect(session[:user_id]).to equal(assigns(:user).id)
      end
      
      it 'redirects to the created user' do
        post :create, params: valid_params
        expect(response).to redirect_to user_url(assigns(:user))
      end
    end

    context 'with invalid attributes' do
      let(:invalid_params) {
        {
          user: {
            email: 'test@example.com'
          } 
        }
      }

      it 'does not create a new user' do
        expect { post :create, params: invalid_params }.to_not change(User, :count)
      end

      it 'renders new' do
        post :create, params: invalid_params
        expect(response).to render_template :new
      end
    end
  end
end