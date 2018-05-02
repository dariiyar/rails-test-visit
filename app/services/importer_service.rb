require 'csv'

class ImporterService
  attr_reader :errors
  REQUIRED_ATTRIBUTES = %w[name date number description].freeze

  def initialize(file)
    @file = file
    @errors =[]
  end

  def call
    validation
  end

  private

  def validation
    attributes_keys = CSV.read(@file.path, headers: false, col_sep: ',').first.map(&:downcase)
    required_attributes_existense(attributes_keys)
    extra_attributes_existense(attributes_keys)
  end

  def required_attributes_existense(attributes_keys)
    attributes_keys = REQUIRED_ATTRIBUTES - attributes_keys
    errors << "required attributes does not set: #{attributes_keys}" if attributes_keys.any?
  end

  def extra_attributes_existense(attributes_keys)
    attributes_keys = attributes_keys - REQUIRED_ATTRIBUTES
    errors << "these attributes aren't allowed: #{attributes_keys}" if attributes_keys.any?
  end
end