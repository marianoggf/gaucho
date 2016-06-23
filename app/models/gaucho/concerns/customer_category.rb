module Gaucho::Concerns::CustomerCategory
  extend ActiveSupport::Concern
  include Gaucho::Concerns::Indestructible

  included do
    has_many :customers, dependent: :restrict_with_error

    validates :name, presence: true, uniqueness: true

    before_destroy :check_dependencies_gaucho
  end

end