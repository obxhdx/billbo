require 'spec_helper'

describe Bill do
  let!(:bill) { FactoryGirl.build(:bill) }

  it 'compares equal attributes of two bills' do
    bill_cloned = bill.clone
    (bill == bill_cloned).should be_true
    (bill.eql? bill_cloned).should be_true
  end

  xit 'compares different attributes of two bills' do
    bill_different_id = FactoryGirl.build(:bill, id: 10)
    (bill_different_id == bill).should be_false
  end

  it 'saves a bill' do
    expect { bill.save }.to change { Bill.count }.by(1)
    bill_found = Bill.find(bill.id)
    (bill == bill_found).should be_true
  end

  it 'creates a bill' do
    bill_to_be_created = FactoryGirl.build(:bill, id: 0)
    Bill.create(bill_to_be_created.to_hash).stub(:save)
    bill_created = Bill.create(bill_to_be_created.to_hash)
    bill_created.id.should_not == 0
  end

  it 'finds a bill by id' do
    bill.save
    bill_found = Bill.find(bill.id)
    (bill == bill_found).should be_true
  end

  it 'counts the amount of bills' do
    Bill.count.should == 0
    bill.save
    Bill.count.should == 1
  end

  it 'gets all bills' do
    number_of_bills = 5
    bills = FactoryGirl.build_list(:bill, number_of_bills)
    bills.each { |b| b.save }
    bills_fetched = Bill.all
    bills_fetched.count.should == bills.count
  end

  it 'gets all bills not closed' do
    number_of_bills = 5
    bills = FactoryGirl.build_list(:bill, number_of_bills)

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
