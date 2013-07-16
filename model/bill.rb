class Bill
  include Mongoid::Document
  field :issued_by, type: String
  field :due_date, type: Date
  field :total_amount, type: Float
  field :barcode, type: String
  field :status, type: Symbol, default: :opened

  def close
    self.status = :closed
    self.save
  end

  def to_s
    "Bill: issued_by:#{self.issued_by}, due_date:#{self.due_date}, total_amount:#{self.total_amount}, barcode:#{self.barcode}, status:#{self.status}"
  end

  def ==(other_bill)
    self.attributes.except('_id').eql? other_bill.attributes.except('_id')
  end

  def to_hash
    hash = {}
    instance_variables.each do
      |var| hash[var.to_s.delete("@")] = instance_variable_get(var)
    end
    hash
  end
end
