module Gaucho::Concerns::CustomerCaMovement
  extend ActiveSupport::Concern

  included do

    before_validation :calculate_previous_balance
    before_create :set_status_to_active
    before_destroy :cancel_destroy, if: 'sale.present? and !sale.destroyed?'

    validates :customer_ca_movement_category, :amount, :date, :customer, :previous_balance, presence: true
    validates :customer_ca_movement_category, :amount, :date, :customer, presence: true
    validates :amount, numericality: { greater_than: 0 }
    validates :previous_balance, numericality: true

    belongs_to :customer_ca_movement_status  
    belongs_to :customer
    belongs_to :customer_ca_movement_category
    has_one :sale, inverse_of: :customer_ca_movement
    
    after_save :recalculate_following_movement_previous_balance, if: "following.present?"

    scope :ordered, -> { order date: :desc, id: :desc }
    scope :from_customer, -> (customer) { where customer: customer }
    scope :equal_than, -> (mov) { where(date: mov.date) }
    scope :older_than, -> (mov) { where("date < ?", mov.date) }
    scope :older_or_equal_than, -> (mov) { where("date <= ?", mov.date) }
    scope :newer_or_equal_than, -> (mov) { where("date >= ?", mov.date) }
    scope :newer_than, -> (mov) { where("date > ?", mov.date) }
    scope :with_id_less_than, -> (id) { where("id < ?", id) }
    scope :with_id_greater_than, -> (id) { where("id > ?", id) }
    scope :with_customer_id, -> (customer_id) { where customer_id: customer_id  } 
    scope :with_customer_ca_movement_category_id, -> (customer_ca_movement_category_id) { where customer_ca_movement_category_id: customer_ca_movement_category_id }
    scope :with_customer_ca_movement_status_id, -> (customer_ca_movement_status_id) { where customer_ca_movement_status_id: customer_ca_movement_status_id }
    scope :without_id, -> (id) { where.not id: id }
    scope :between, -> (date_1, date_2) { where date: date_1 .. date_2 }
    scope :actives, ->{ where customer_ca_movement_status_id: 1 }
    scope :income, -> { actives.joins(:customer_ca_movement_category).where(customer_ca_movement_categories: {is_income: true}) }
    scope :egress, -> { actives.joins(:customer_ca_movement_category).where(customer_ca_movement_categories: {is_income: false}) }

  end

  def following
    my_active_movements = CustomerCaMovement.from_customer(customer).actives.ordered
    following = if persisted?
      following = my_active_movements.without_id(id)
      if (following.equal_than(self).present? and following.equal_than(self).with_id_greater_than(id).blank?) or following.equal_than(self).blank?
        following.newer_than(self)
      else
        following.equal_than(self).with_id_greater_than(id)
      end
    else
      my_active_movements.newer_or_equal_than(self)
    end
    following.ordered.last
  end

  def previous
    my_active_movements = CustomerCaMovement.from_customer(customer).actives.ordered
    previous = if persisted?
      previous = my_active_movements.without_id(id)
      if (previous.equal_than(self).present? and previous.equal_than(self).with_id_less_than(id).blank?) or previous.equal_than(self).blank? 
        previous.older_than(self)
      else
        previous.equal_than(self).with_id_less_than(id)
      end
    else
      my_active_movements.older_or_equal_than(self)
    end
    previous.ordered.first
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

    def set_status_to_active
      self.customer_ca_movement_status_id = 1
    end

    def cancel_destroy
      errors.add(:sale, "No se puede eliminar porque tiene una venta asociada")
      return false
    end
end



