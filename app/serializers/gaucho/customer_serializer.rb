class Gaucho::CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :cuit, :address, :tu_puta_madre

  def tu_puta_madre
    "Me recontra cago en la reconcha de tu hermano"
  end
end
