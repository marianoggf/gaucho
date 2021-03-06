module Gaucho::Concerns::SaleDetail
  extend ActiveSupport::Concern
    
  included do
    belongs_to :sale, inverse_of: :sale_details
    validates :unit_price, :quantity, :sale, :iva, presence: true
    validates :iva, numericality: { greater_than_or_equal_to: 0 }
    validates :unit_price, :quantity, numericality: { greater_than: 0 }
  end

  def subtotal
    (self.unit_price * self.quantity) * ( 1 + 0.01 * self.iva )
  end
  
end
