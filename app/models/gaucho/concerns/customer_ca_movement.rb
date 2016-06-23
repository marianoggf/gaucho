module Gaucho::Concerns::CustomerCaMovement
  extend ActiveSupport::Concern

  included do

    before_validation :calculate_previous_balance

    validates :customer_ca_movement_category, :amount, :date, :customer, :previous_balance, presence: true
    validates :customer_ca_movement_category, :amount, :date, :customer, presence: true
    validates :amount, numericality: { greater_than: 0 }
    validates :previous_balance, numericality: true
      
    belongs_to :customer
    belongs_to :customer_ca_movement_category
    has_one :sale, dependent: :destroy, inverse_of: :customer_ca_movement

    after_save :recalculate_following_movement_previous_balance, if: "following.present?"

    scope :ordered, -> { order date: :desc, id: :desc }
    scope :of_a_customer, -> (customer) { where customer: customer }
    scope :equal_than, -> (mov) { ordered.of_a_customer(mov.customer).where(date: mov.date).where.not(id: mov.id) }
    scope :older_than, -> (mov) { ordered.of_a_customer(mov.customer).where("date < ?", mov.date).where.not(id: mov.id) }
    scope :older_or_equal_than, -> (mov) { ordered.of_a_customer(mov.customer).where("date <= ?", mov.date).where.not(id: mov.id) }
    scope :newer_or_equal_than, -> (mov) { ordered.of_a_customer(mov.customer).where("date >= ?", mov.date).where.not(id: mov.id) }
    scope :newer_than, -> (mov) { ordered.of_a_customer(mov.customer).where("date > ?", mov.date).where.not(id: mov.id) }
    scope :with_id_less_than, -> (id) { where("id < ?", id) }
    scope :with_id_greater_than, -> (id) { where("id > ?", id) }

  end

  def following
    if persisted?
      if CustomerCaMovement.equal_than(self).present? and CustomerCaMovement.equal_than(self).with_id_greater_than(self.id).blank?
        CustomerCaMovement.newer_than(self).last
      elsif CustomerCaMovement.equal_than(self).present?
        CustomerCaMovement.equal_than(self).with_id_greater_than(id).last
      else
        CustomerCaMovement.newer_than(self).last
      end
    else
      CustomerCaMovement.newer_or_equal_than(self).last
    end
  end

  def previous
    if persisted?
      if CustomerCaMovement.equal_than(self).present? and CustomerCaMovement.equal_than(self).with_id_less_than(self.id).blank?
        CustomerCaMovement.older_than(self).first
      elsif CustomerCaMovement.equal_than(self).present?
        CustomerCaMovement.equal_than(self).with_id_less_than(id).first
      else
        CustomerCaMovement.older_than(self).first
      end
    else
      CustomerCaMovement.older_or_equal_than(self).first
    end
  end

  def signed_amount
    (amount.present? and customer_ca_movement_category.present?) ? ((customer_ca_movement_category.is_income? ? 1 : -1) * amount) : nil
  end

  def accumulated_amount
    signed_amount + previous_balance
  end

  private

    def calculate_previous_balance
      self.previous_balance = previous.present? ?  previous.accumulated_amount : 0
    end

    def recalculate_following_movement_previous_balance
      following.update(previous_balance: accumulated_amount)
    end
end



