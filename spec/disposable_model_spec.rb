require 'spec_helper'

describe DisposableModel do

  it "can be instantiated" do
    m = DisposableModel.factory(:database => Database.new)
    m.new.should be_a_kind_of(Sequel::Model)
  end

  it "has a database" do
    m = DisposableModel.factory(:database => Database.new)
    m.database.should be_a_kind_of(Database)
  end

  it "has a database with connection" do
    m = DisposableModel.factory(:database => Database.new(:connection => Sequel.sqlite))
    m.database.connection.should be_a_kind_of(Sequel::SQLite::Database)
  end

  it "has a database with adjustable connection" do
    m1 = DisposableModel.factory(:database => Database.new(:connection => Sequel.sqlite))
    m2 = DisposableModel.factory(:database => Database.new(:connection => Sequel.sqlite('/tmp/test.db')))
    m1.database.connection.uri.should == 'sqlite:/'
    m2.database.connection.uri.should == 'sqlite://tmp/test.db'
  end

  it "has an underlying table with columns" do
    columns = []
    columns << TableTemplate::Column.new('t1', Integer)
    columns << TableTemplate::Column.new('t2', String)

    tt = TableTemplate.new('foo', columns)

    database = Databases::SQLite.new
    database.create_table! tt

    m = DisposableModel.factory(:database => database, :table_name => tt.name)
    m.columns.length.should == columns.length
  end

  it "can paginate" do
    columns = []
    columns << TableTemplate::Column.new('t1', Integer)
    columns << TableTemplate::Column.new('t2', String)

    tt = TableTemplate.new('foo', columns)

    database = Databases::SQLite.new
    database.create_table! tt

    m = DisposableModel.factory(:database => database, :table_name => tt.name)
    m.paginate(1, 50).page_count == 0
  end

end
