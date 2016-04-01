module Gaucho::Concerns::Customer
  extend ActiveSupport::Concern

  included do
    has_many :customer_ca_movements
    before_create :init_total
    validates :name, presence: true
  end

  private

    def init_total
      self.total = 0 if self.total.blank?
    end
end 
