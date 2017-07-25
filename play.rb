Dir[File.join(".", "rpn_cli/*.rb")].each do |file|
  require file
end

interface = CliInterface.new
calculator = RpnCalculator.new
Engine.new(calculator, interface).start
