require 'rails_helper'

describe SessionsController do
  describe 'GET #new' do
    context 'when no user is already logged in' do
      it 'renders new' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when a user is already logged in'  do
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
    context 'with valid parameters' do
      let(:user) { FactoryGirl.create(:user) }
      let(:valid_params) {
        {
          session: {
            email: user.email, password: user.password
          }
        }
      }

      it 'logs the user in' do
        post :create, params: valid_params
        expect(session[:user_id]).to equal(user.id)
      end

      it 'redirects to the user' do
        post :create, params: valid_params
        expect(response).to redirect_to user_url(user)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) {
        {
          session: {
            email: 'test@example.com'
          }
        }
      }

      it 'renders new' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end

    context 'with an incorrect password' do
      let(:user) { FactoryGirl.create(:user) }
      let(:incorrect_password_params) {
        {
          session: {
            email: user.email, password: "#{user.password}1"
          }
        }
      }

      it 'renders new' do
        post :create, params: incorrect_password_params
        expect(response).to render_template(:new)
      end
    end

    context 'with an unknown email' do
      let(:unknown_email_params) {
        {
          session: {
            email: 'unknown@example.com', password: '1234'
          }
        }
      }

      it 'renders new' do
        post :create, params: unknown_email_params
        expect(response).to render_template(:new)
      end
    end
  end
end