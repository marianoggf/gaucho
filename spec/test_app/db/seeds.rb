CustomerCaMovementCategory.find_or_create_by! id: 1, name: "Pago", is_income: true, manual: true
CustomerCaMovementCategory.find_or_create_by! id: 2, name: "Salida Estandar", is_income: false, manual: true
CustomerCaMovementCategory.find_or_create_by! id: 3, name: "Venta", is_income: false, manual: false

CustomerCategory.find_or_create_by! id: 1, name: "Consumidor final"
CustomerCategory.find_or_create_by! id: 2, name: "Minorista"
CustomerCategory.find_or_create_by! id: 3, name: "Mayorista"
CustomerCategory.find_or_create_by! id: 4, name: "Distribuidor"
CustomerCategory.find_or_create_by! id: 5, name: "Otros"

ReceiptCategory.find_or_create_by! id: 1, name: "Factura"
ReceiptCategory.find_or_create_by! id: 2, name: "Comprobante interno"

ReceiptType.find_or_create_by! id: 1, name: "Tipo A"
ReceiptType.find_or_create_by! id: 2, name: "Tipo B"
ReceiptType.find_or_create_by! id: 3, name: "Tipo C"
ReceiptType.find_or_create_by! id: 4, name: "Tipo X"