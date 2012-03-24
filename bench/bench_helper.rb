require 'rubygems'
require 'bundler/setup'
require 'ffaker'
require 'benchmark'
require 'disposable_db'
require 'fileutils'

include DisposableDB

class TableTemplate::Column

  def mock
    if self.type.kind_of?(Numeric)
      rand(999999999999999)
    else
      Faker::Name.name
    end
  end
end

def generate_random_data(column_names, prefix = nil)
  data = {}
  column_names.each do |cn|
    data[:"#{prefix}#{cn.to_s}"] = Faker::Name.name
  end
  data
end