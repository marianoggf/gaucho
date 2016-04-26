module Gaucho::Concerns::Indestructible
  extend ActiveSupport::Concern

  def destroy
    false
  end

end