module Gaucho::Concerns::Receipt
  extend ActiveSupport::Concern

  included do
    has_many :receipt_details, dependent: :destroy
    belongs_to :customer
    belongs_to :receipt_type
    belongs_to :receipt_category

    validates :number, :customer, :receipt_type, :receipt_category, presence: true
    validates :number, uniqueness: true

    accepts_nested_attributes_for :receipt_details, allow_destroy: true
  end

  def total
    self.receipt_details.sum("unit_price * quantity * ( 1 + ( 0.01 * iva ) )")  
  end



end