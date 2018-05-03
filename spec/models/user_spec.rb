require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name) }
  it { expect(subject).to validate_numericality_of(:number).only_integer }
end
