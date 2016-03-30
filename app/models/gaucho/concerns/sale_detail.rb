module Gaucho::Concerns::SaleDetail
  extend ActiveSupport::Concern
    
  included do
    belongs_to :sale
    validates :unit_price, :quantity, :sale, :iva, presence: true
  end

  def subtotal
    (self.unit_price * self.quantity) * ( 1 + 0.01 * self.iva )
  end
  
end
