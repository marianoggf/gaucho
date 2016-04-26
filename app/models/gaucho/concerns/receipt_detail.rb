module Gaucho::Concerns::ReceiptDetail
  extend ActiveSupport::Concern

  included do
    belongs_to :receipt

    validates :unit_price, :quantity, :iva, :description, presence: true
    validates :unit_price, :quantity, :iva, numericality: { greater_than_or_equal_to: 0 }
  end

  def subtotal
    (self.unit_price * self.quantity) * ( 1 + 0.01 * self.iva )
  end

end