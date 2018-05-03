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
    import if errors.empty?
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

  def import
    CSV.foreach(@file.path, headers: true, col_sep: ',') do |row|
      hash = row_to_lower_keys_hash(row)
      user = User.find_by(name: hash['name'])
      begin
        user.present? ? user.update(hash) :  User.create!(hash)
      rescue Exception => e
        errors << "#{e.message} - #{hash}"
      end
    end
  end

  def row_to_lower_keys_hash(row)
    hash = {}
    row.to_hash.each_pair { |k, v| hash.merge!(k.downcase => v) }
    hash
  end
end