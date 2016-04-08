module Gaucho::Concerns::Customer
  extend ActiveSupport::Concern

  included do
    has_many :customer_ca_movements
    has_many :sales

    validates :name, presence: true
    
    before_create :init_total
    before_destroy :check_dependencies_gaucho
  end

  private

    def init_total
      self.total = 0 if self.total.blank?
    end

    def check_dependencies_gaucho
      can_destroy = true
      if self.sales.present?
        errors[:delete] << "No se puede eliminar porque está asociado a una o varias ventas."
        can_destroy = false
      end
      if self.customer_ca_movements.present?
        errors[:delete] << "No se puede eliminar porque está asociado a una o varios movimientos de cuenta corriente."
        can_destroy = false
      end
      return can_destroy
    end
end 
