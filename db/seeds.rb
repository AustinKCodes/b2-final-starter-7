# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

merchant1 = Merchant.create(name: "Poseidon Pools")
merchant2 = Merchant.create(name: "Hair Care")

item1 = Item.create(name: "Chlorine Tablet", description: "Chlorine in tablet form", unit_price: 5, merchant_id: merchant1.id)
item2 = Item.create(name: "Shock Pack", description: "Pool Chemicals", unit_price: 10, merchant_id: merchant1.id)
item3 = Item.create(name: "Shampoo", description: "Hair smell good", unit_price: 10, merchant_id: merchant2.id)
item4 = Item.create(name: "Conditioner", description: "Shiny hair maker", unit_price: 10, merchant_id: merchant2.id)

coupon1 = Coupon.create(name: "Coupon 1", code: "SAVE10" ,discount_type: "percent", discount_amount: 10, active: true, merchant: merchant1)
coupon2 = Coupon.create(name: "Coupon 2", code: "FIVEOFF", discount_type: "dollar", discount_amount: 5, active: true, merchant: merchant2)

customer_1 = Customer.create(first_name: "Joey", last_name: "Smith")
customer_2 = Customer.create(first_name: "Cecilia", last_name: "Jones")

invoice_2 = Invoice.create(customer_id: customer_1.id, status: 2)
invoice_3 = Invoice.create(customer_id: customer_2.id, status: 2)
invoice_1 = Invoice.create(customer_id: customer_2.id, status: 2, coupon: coupon1)
invoice_4 = Invoice.create(customer_id: customer_1.id, status: 2, coupon: coupon2)

ii_1 = InvoiceItem.create(invoice: invoice_2, item: item1, quantity: 1, unit_price: item1.unit_price)
ii_2 = InvoiceItem.create(invoice: invoice_4, item: item2, quantity: 2, unit_price: item2.unit_price)
ii_3 = InvoiceItem.create(invoice: invoice_3, item: item3, quantity: 2, unit_price: item3.unit_price)
ii_4 = InvoiceItem.create(invoice: invoice_1, item: item4, quantity: 3, unit_price: item4.unit_price)

transaction1 = Transaction.create(credit_card_number: 243155, result: 1, invoice_id: invoice_2.id)
transaction2 = Transaction.create(credit_card_number: 243155, result: 1, invoice_id: invoice_4.id)
transaction3 = Transaction.create(credit_card_number: 246151, result: 1, invoice_id: invoice_3.id)
transaction4 = Transaction.create(credit_card_number: 246151, result: 1, invoice_id: invoice_1.id)