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
    end

    context 'with valid data' do

    end
  end
end

def call_service(path)
  @service = ImporterService.new(File.new(Rails.root.join(path)))
  @service.call
end