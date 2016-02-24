module Gaucho
  class CustomerCaMovement < ActiveRecord::Base
    belongs_to :customer
    belongs_to :customer_ca_movement_type
  end
end
