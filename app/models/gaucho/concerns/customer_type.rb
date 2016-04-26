module Gaucho::Concerns::CustomerType
  extend ActiveSupport::Concern
  include Gaucho::Concerns::Indestructible

  included do
    has_many :customers

    validates :name, presence: true, uniqueness: true

    before_destroy :check_dependencies_gaucho
  end

    def check_dependencies_gaucho
      can_destroy = true
      if self.customers.present?
        errors[:delete] << "No se puede eliminar porque está asociado a una o varios clientes."
        can_destroy = false
      end
      return can_destroy
    end

end