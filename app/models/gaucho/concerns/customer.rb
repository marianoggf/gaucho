module Gaucho::Concerns::Customer
  extend ActiveSupport::Concern

  included do

    has_many :customer_ca_movements, dependent: :restrict_with_error
    has_many :sales, dependent: :restrict_with_error
    belongs_to :customer_category

    validates :name, presence: true, uniqueness: true
    validates :cuit, uniqueness: true, allow_blank: true
    
  end

  def total
    customer_ca_movements.reload.present? ? customer_ca_movements.ordered.first.accumulated_amount : 0
  end

end