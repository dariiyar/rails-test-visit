require 'rails_helper'

RSpec.describe ImporterService do
  describe "Imports CSV with user's data" do
    context 'with invalid data' do
      context 'extra csv attributes are present' do
        it 'has an error with a list of extra attributes' do
          call_service('spec/fixtures/csv/invalid_extra.csv')
          expect(@service.errors.first).to include 'extra_attribute'
        end
      end
      context 'some csv attributes are absent' do
        it 'has an error with a list of absent attributes' do
          call_service('spec/fixtures/csv/invalid_absent.csv')
          expect(@service.errors.first).to include 'description'
        end
      end

      context 'wrong value in number csv attributes' do
        before :each do
          call_service('spec/fixtures/csv/invalid_attr_value.csv')
        end
        it "doesn't create a user" do
          expect(User.count).to eq 1
        end

        it 'returns an error message' do
          expect(@service.errors.first).to include 'Validation failed'
        end
      end
      it "doesn't create a list of users" do
        call_service('spec/fixtures/csv/invalid_absent.csv')
        expect(User.count).to eq 0
      end
    end

    context 'with valid data' do
      context "users in csv don't exist" do
        it 'creates a list of users' do
          call_service('spec/fixtures/csv/valid.csv')
          expect(User.count).to eq 2
        end
      end
      context "users in csv  exist" do
        it 'updates users number attribute' do
          call_service('spec/fixtures/csv/valid.csv')
          user = User.find_by(name: 'Paul')
          call_service('spec/fixtures/csv/update_valid.csv')
          user.reload
          expect(user.number).to eq 99
        end
      end
    end
  end
end

def call_service(path)
  @service = ImporterService.new(fixture_file_upload(Rails.root.join(path)))
  @service.call
end