desc "Crea las instancias de modelos necesarias (tipo seeds)"

task :gaucho do
  CustomerCaMovementType.find_or_create_by!(id: 1, name: "Pago", is_income: true)
  CustomerCaMovementType.find_or_create_by!(id: 2, name: "Salida", is_income: false)
end
