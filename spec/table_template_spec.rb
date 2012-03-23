require 'spec_helper'

describe TableTemplate do

  it "can be instantiated" do
    tt = TableTemplate.new('foo')
    tt.should be_an_instance_of(TableTemplate)
  end

  it "can add columns" do
    tt = TableTemplate.new('foo')
    columns = []
    columns << TableTemplate::Column.new('t1', Integer)
    columns << TableTemplate::Column.new('t2', String)

    columns.each do |column|
      tt.add_column column
    end

    tt.columns.length.should == columns.length
  end

end
