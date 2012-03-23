require 'spec_helper'

describe DisposableDB do
  it "can log" do
    tf = Tempfile.new('output.txt')
    CDRTools.logger = Logger.new(tf)
    CDRTools.log 'foobar'
    tf.close
    File.read(tf.path).should =~ /foobar/
  end
end
