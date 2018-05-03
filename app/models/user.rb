class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :number, numericality: { only_integer: true }
end
