3.times {
  Bill.create(
    issued_by:    'company1',
    due_date:     '25-02-2013',
    total_amount: 45.9,
    barcode:      '0000000000000000000000001')
}
