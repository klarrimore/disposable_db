require 'spec_helper'

describe DisposableDB do
  it "can log" do
    tf = Tempfile.new('output.txt')
    DisposableDB.logger = Logger.new(tf)
    DisposableDB.log 'foobar'
    tf.close
    File.read(tf.path).should =~ /foobar/
  end
end
