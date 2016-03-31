module Gaucho::Concerns::CustomerCaMovement
  extend ActiveSupport::Concern

  included do

    validates :customer_ca_movement_type, :amount, :date, :customer, presence: true
    
    before_save :calculate_ca_total, if: Proc.new { |customer| customer.present? }
    before_save :calculate_previous_balance
    before_destroy { mark_for_destruction }
    after_destroy :subtract_amount_to_customers_total
  
    belongs_to :customer
    belongs_to :customer_ca_movement_type
    has_one :sale, dependent: :destroy, inverse_of: :customer_ca_movement

  end

  def following
    (CustomerCaMovement.where("date = '#{self.date}' #{"AND id > #{self.id}" if self.persisted?} ") || CustomerCaMovement.where("date > '#{self.date}'").where.not(id: self.id)).order(date: :asc, id: :asc).first
  end

  def previous
    (CustomerCaMovement.where("date = '#{self.date}' #{"AND id < #{self.id}" if self.persisted?} ") || CustomerCaMovement.where("date < '#{self.date}'").where.not(id: self.id)).order(date: :desc, id: :desc).first
  end

  def signed_amount
    (self.amount.present? and self.customer_ca_movement_type.present?) ? ((self.customer_ca_movement_type.is_income? ? 1 : -1) * amount) : nil
  end

  private

    def calculate_previous_balance
      self.previous_balance = previous.present? ?  previous.previous_balance + previous.amount : 0
    end

    def calculate_ca_total
      self.customer.total += self.signed_amount 
      # (self.persisted? ? CustomerCaMovement.find(self.id).signed_amount : 0)
    end

    def subtract_amount_to_customers_total
      self.customer.total -= self.signed_amount
    end

end