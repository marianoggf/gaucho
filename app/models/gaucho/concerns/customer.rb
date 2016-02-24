module Gaucho::Concerns::Customer
  extend ActiveSupport::Concern

  included do
    has_many :customer_ca_movement
  end
  
end 
