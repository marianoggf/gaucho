module Gaucho::Concerns::Sale
  extend ActiveSupport::Concern
    
  included do

    before_create :create_customer_ca_movement
    before_destroy :is_movement_the_destroyer?
    
    validates :date, presence: true
    validates :archivable, inclusion: [true, false]
    validates_associated :customer_ca_movement
    validates_associated :sale_details

    belongs_to :customer
    belongs_to :customer_ca_movement, inverse_of: :sale
    has_many :sale_details, inverse_of: :sale, dependent: :destroy

    accepts_nested_attributes_for :sale_details, allow_destroy: true
  end

  def total
    total = 0
    self.sale_details.each { |detail| total += detail.subtotal }
    return total
  end

  private

    def create_customer_ca_movement
      self.customer_ca_movement = CustomerCaMovement.create date: self.date, amount: self.total, customer: self.customer, customer_ca_movement_type_id: CustomerCaMovementType.types[:sale]
    end

    def is_movement_the_destroyer?
      false unless self.customer_ca_movement.marked_for_destruction?
    end
end
