module Gaucho::Concerns::CustomerCaMovementStatus
  extend ActiveSupport::Concern
  include Gaucho::Concerns::Indestructible

  included do
    validates :code, :name, uniqueness: true, presence: true

    has_many :customer_ca_movements
  end
  
end 
