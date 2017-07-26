Dir[File.join(".", "rpn_cli/*.rb")].each do |file|
  require file
end
require 'rspec'
require 'aruba/rspec'
