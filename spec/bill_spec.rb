require 'spec_helper'

describe Bill do
  let!(:bill) { FactoryGirl.build(:bill) }

  it 'saves a bill successfully' do
    expect { bill.save }.to change { Bill.count }.by(1)
    bill_found = Bill.find(bill.id)
    (bill == bill_found).should be_true
  end

  it 'closes a bill' do
    bill.status.should == :opened
    bill.close
    bill.status.should == :closed
  end

  it 'prints a bill' do
    expected = "Bill: issued_by:#{bill.issued_by}, due_date:#{bill.due_date}, total_amount:#{bill.total_amount}, barcode:#{bill.barcode}, status:#{bill.status}"
    bill.to_s.should == expected
  end
end
