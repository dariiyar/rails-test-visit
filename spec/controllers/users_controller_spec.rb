require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "POST #import" do
    it "retunrs a success responce" do
      @file = fixture_file_upload(Rails.root.join('spec/fixtures/csv/valid.csv'))
      post :import, params: { file: @file}, :format => 'js'
      expect(response).to be_success
    end
  end
end
