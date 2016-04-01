module Gaucho::Concerns::CustomerCaMovementType
  extend ActiveSupport::Concern


  included do
    enum type: { income: 1, egress: 2, sale: 3}
    
    has_many :customer_ca_movements
    validates :name, presence: true
    validates :manual, inclusion: [true, false]
  end
  
end 
