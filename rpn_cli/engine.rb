require 'byebug'
class Engine
  WELCOME_MESSAGE = 'Welcome to basic RPN calculator'
  HELP_MESSAGE = <<-eos
  CHOOSE any number or any of four basic arithmic operators and PRESS enter
  PRESS
    'q' to quit
    'h' to view help
    's' to view current operand stack
    'r' to clear out and reset the stack
  **
  - Operand stack is a set of numbers you have put in
    that have not been evaluated
  - Operand stack needs to have at least two numbers
    before putting an operator in
  eos

  SHUTDOWN_MESSAGE = "Shutting down"

  def initialize(calculator, interface)
    @calculator = calculator
    @interface = interface
  end

  def start
    interface.display(WELCOME_MESSAGE + "\n" + HELP_MESSAGE)
    loop do
      begin
        trap_ctrl_c
        interface.prompt
        input = interface.parse_input
        case input
        when 'q'
          stop
        when 'h'
          interface.display(HELP_MESSAGE)
        when 's'
          interface.display(calculator.operand_stack.join(" ").to_s)
        when 'r'
          calculator.operand_stack = []
        else
          interface.display(calculator.calculate(input).to_s)
        end
      rescue => exception
        interface.error(exception)
        redo
      end
    end
  end

  private
  attr_reader :calculator, :interface

  def trap_ctrl_c
    trap("INT") do
      stop
    end
  end

  def stop
    interface.display(SHUTDOWN_MESSAGE)
    exit
  end
end
