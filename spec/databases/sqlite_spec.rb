require 'spec_helper'

describe SQLite do
  it "can be instantiated" do
    db = Databases::SQLite.new
    db.should be_a_kind_of(SQLite)
  end

  it "has a connection" do
    db = Databases::SQLite.new
    db.connection.should be_a_kind_of(Sequel::SQLite::Database)
  end
  
  it "can set correct connection path" do
    tf = Tempfile.new ['displosable_db_sqlite_spec_', '.db']
    db = Databases::SQLite.new :db_path => tf.path
    db.connection.uri.should == "sqlite:/#{tf.path}"
  end

end
