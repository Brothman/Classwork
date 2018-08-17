require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #Test: 1.Status Codes and Responses Under Various Conditions
  #Test: Valid and Invalid params

  #Test: Various Conditions, at least for now, means under Valid and Invalid Params -> For Get Requests, there are no params.
  #Test: Responses


  context "GET #index" do
    it "should render the index view" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should return a 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context "GET #new" do
    it "should render the new user form" do
      get :new
      expect(response).to render_template(:new)
    end

    it "should return a 200 status code" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  context "POST #create" do
    #Password is too short
    let(:invalid_params) { { user: {username: 'asdfasdf', password: "12345"} } }

    #Password is at least 6 characters
    let(:valid_params) { { user: {username: 'asdfasdf', password: "123456"} } }

    context 'valid parameters' do

      it "should redirect to the show page" do
        post :create, params: valid_params
        expect(response).to redirect_to(user_url(User.last))
      end

      it "should return a 302 status code " do
        post :create, params: valid_params
        expect(response).to have_http_status(302)
      end

      it "should log in the user" do
        expect(subject).to receive(:login).with(User)
        post :create, params: valid_params
      end
    end

    context 'invalid parameters' do
      it "should render the new page" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end

      it "should return a 200 status code " do
        post :create, params: invalid_params
        expect(response).to have_http_status(200)
      end

      it "should NOT log in the user" do
        expect(subject).not_to receive(:login).with(User.last)
        post :create, params: invalid_params
      end
    end
  end

  context 'GET #edit' do

    let(:valid_params) do
      create(:user)
      return { id: User.last.id }
    end

    let(:invalid_params) do
      { id: 10000 }
    end

    let(:valid_response) do
      get :edit, params: valid_params
      response
    end

    let (:invalid_response) do
      get :edit, params: invalid_params
      response
    end

    context 'valid user ID' do
      it 'should render the edit page' do
        expect(valid_response).to render_template(:edit)
      end

      it 'should render a 200 status code' do
        expect(valid_response).to have_http_status(200)
      end
    end

    context 'invalid user ID' do
      it 'should redirect to user index page' do
        expect(invalid_response).to redirect_to(users_url)
      end

      it 'should render a 302 status code' do
        expect(invalid_response).to have_http_status(302)
      end
    end

  end

  context 'PATCH #update' do
    #Password is too short
    subject(:user) { create :user }
    let(:invalid_params) { { user: { password: "12345"}, id: user.id } }
    #Password is at least 6 characters
    let(:valid_params) { { user: { password: "234567"}, id: user.id } }

    let(:valid_response) do
        patch :update, params: valid_params
        response
    end

    let(:invalid_response) do
        patch :update, params: invalid_params
        response
    end

    context 'valid parameters' do

      it "should redirect to the show page" do
        expect(valid_response).to redirect_to(user_url(user))
      end

      it "should return a 302 status code " do
        expect(valid_response).to have_http_status(302)
      end
    end

    context 'invalid parameters' do
      it "should render the edit page" do
        expect(invalid_response).to render_template(:edit)
      end

      it "should return a 200 status code " do
        expect(invalid_response).to have_http_status(200)
      end

      it "should have errors" do
        invalid_response
        expect(flash.now[:errors]).to be_present
      end
    end
  end

  context 'DELETE #destroy' do
    let!(:user) { create(:user) }
    before(:each) do
      delete :destroy, params: { id: user.id }
    end

    it "destroys user" do
      expect(User.exists?(user.id)).to be false
    end
  end

  context 'GET #show' do

    let(:valid_params) do
      create(:user)
      return { id: User.last.id }
    end

    let(:invalid_params) do
      { id: 10000 }
    end

    let(:valid_response) do
      get :show, params: valid_params
      response
    end

    let (:invalid_response) do
      get :show, params: invalid_params
      response
    end

    context 'valid user ID' do
      it 'should render the show page' do
        expect(valid_response).to render_template(:show)
      end

      it 'should return a 200 status' do
        expect(valid_response).to have_http_status(200)
      end
    end

    context 'invalid user ID' do
      it 'should redirect to the index page' do
        expect(invalid_response).to redirect_to(users_url)
      end

      it 'should return a 302 status' do
        expect(invalid_response).to have_http_status(302)
      end

      it 'should have errors' do
        invalid_response
        expect(flash[:errors]).to be_present
      end
    end
  end

  #edit, update, create, show


end
