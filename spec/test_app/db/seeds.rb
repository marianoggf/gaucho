CustomerCaMovementType.find_or_create_by! id: 1, name: "Pago", is_income: true, manual: true
CustomerCaMovementType.find_or_create_by! id: 2, name: "Salida Estandar", is_income: false, manual: true
CustomerCaMovementType.find_or_create_by! id: 3, name: "Venta", is_income: false, manual: false
