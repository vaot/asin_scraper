class Product < ActiveRecord::Base
  include Enumerables

  # ======= Constants
  STATUSES = {
    inactive: 'inactive',
    active: 'active'
  }

  # ======= Scopes
  setup_enumerable(STATUSES.values, :status)

  # ======= Validations
  validates :asin, presence: true, uniqueness: true
end
