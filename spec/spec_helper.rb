require 'rspec'
Dir[File.join(".", "rpn_cli/*.rb")].each do |file|
  require file
end
