require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "POST #import" do
    context 'valid csv file' do
      it "returns a success responce" do
        @file = fixture_file_upload(Rails.root.join('spec/fixtures/csv/valid.csv'))
        post :import, params: { file: @file }, format: :json
        expect(response).to be_success
      end
    end
    context 'invalid csv file' do
      it "responce with error status 422" do
        @file = fixture_file_upload(Rails.root.join('spec/fixtures/csv/invalid_absent.csv'))
        post :import, params: { file: @file }, format: :json
        expect(response.status).to eq 422
      end
    end
  end
end
