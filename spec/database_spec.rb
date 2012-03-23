require 'spec_helper'

include DisposableDB::Databases

describe Database do

  it "can be instantiated" do
    Database.new.should be_an_instance_of(Database)
  end

  it "can create table" do
    columns = []
    columns << TableTemplate::Column.new('t1', Integer)
    columns << TableTemplate::Column.new('t2', String)

    tt = TableTemplate.new('foo', columns)

    d = Database.new
    d.table_exists?(tt.name).should be_false
    d.create_table tt
    d.table_exists?(tt.name).should be_true
  end

end
