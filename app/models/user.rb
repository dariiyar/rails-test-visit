class User < ActiveRecord::Base
  include Filterable

  validates :name, presence: true, uniqueness: true
  validates :number, numericality: { only_integer: true }

  scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
  scope :number, -> (number) { where number: number }
  scope :in_description, -> (description) { where("description like ?", "%#{description}%") }
  scope :date, -> (date) { (where date: date) }
end
