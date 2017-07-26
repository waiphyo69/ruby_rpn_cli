class RpnCalculator

  ALLOWED_OPERATOR = /^(\+|-|\*|\/)$/
  ALLOWED_OPERAND = /(^[+-]?(?:0|[1-9]\d*)(?:\.(?:\d*[1-9]|0))?)$/
  INSUFFICIENT_OPERAND_ERROR = 'Operand stack has less than two numbers. Please enter a number instead'
  INVALID_INPUT_FORMAT_ERROR = 'Invalid input detected. Please enter a number or an operator'

  attr_accessor :operand_stack

  def initialize
    @operand_stack = []
  end

  def calculate(char)
    if char =~ ALLOWED_OPERATOR
      handle_operator(char)
    elsif char =~ ALLOWED_OPERAND
      handle_operand(char)
    else
      raise INVALID_INPUT_FORMAT_ERROR
    end
    operand_stack.last
  end

  private
  def handle_operator(operator)
    if operand_stack.length < 2
      raise INSUFFICIENT_OPERAND_ERROR
    else
      eval_last_two_operands(operator)
    end
  end

  def handle_operand(operand)
    operand_stack.push(operand.to_f)
  end

  def eval_last_two_operands(operator)
    operands = operand_stack.pop(2)
    operand_stack.push(operands[0].send(operator, operands[1]))
  end
end
