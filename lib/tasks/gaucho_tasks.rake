desc "Crea las instancias de modelos necesarias (tipo seeds)"

task :gaucho do
  CustomerCaMovementCategory.find_or_create_by!(id: 1, name: "Pago", is_income: true)
  CustomerCaMovementCategory.find_or_create_by!(id: 2, name: "Salida", is_income: false)
end
