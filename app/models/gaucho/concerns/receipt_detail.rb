module Gaucho::Concerns::ReceiptDetail
  extend ActiveSupport::Concern

  included do
    belongs_to :receipt

    validates :unit_price, :quantity, :iva, :description, presence: true
    validates :unit_price, :quantity, :iva, numericality: { greater_than_or_equal_to: 0 }
  end

end