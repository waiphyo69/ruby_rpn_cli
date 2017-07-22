Module RpnCli
  class Calculator

    ALLOWED_OPERATOR = /^(\+|-|\*|\/)$/
    ALLOWED_OPERAND = /(^[+-]?(?:0|[1-9]\d*)(?:\.(?:\d*[1-9]|0))?)$/
    MAX_INPUT_COUNT = 50

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
        raise 'Input format is invalid'
      end
      operand_stack.last
    end

    end

    private
    def validate_input
      if input.split(" ").length == 0
        raise 'No input detected'
      elsif input.length > max_input_count
        raise 'Input length exceeded maximum allowed characters'
      elsif !ALLOWED_OPERANDS.include?(input.last)
        raise 'The last character has to be an operator'
      elsif
    end

    def handle_operator(operator)
      if operand_stack.length < 2
        raise 'Two values need to be entered first before any operators'
      else
        eval_last_two_operands
      end
    end

    def handle_operand(operand)
      operand_stack.push(operand)
    end

    def eval_last_two_operands
      operands = operand_stack.pop(2)
      operand_stack.push(operands[0].send(operator, operands[1]))
    end
  end
end
