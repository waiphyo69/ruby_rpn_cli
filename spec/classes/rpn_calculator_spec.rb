require 'spec_helper'

describe RpnCalculator do

  before :each do
    @calculator = described_class.new
  end

  describe '#calculate' do

    context 'when processing an operator input' do
     it 'properly raises a suitable error message when operand stack does not have enough operands' do
       expect do
         @calculator.calculate('-')
       end.to raise_error(described_class::INSUFFICIENT_OPERAND_ERROR)
     end

     it 'properly performs subtraction between last two operands in the stack' do
       @calculator.operand_stack = [1.0, 2.0]
       result = @calculator.calculate('-')
       expect(result).to eq -1.0
     end

     it 'properly performs addition between last two operands in the stack' do
       @calculator.operand_stack = [1.0, 2.0]
       result = @calculator.calculate('+')
       expect(result).to eq 3.0
     end

     it 'properly performs multiplication between last two operands in the stack' do
       @calculator.operand_stack = [1.0, 2.0]
       result = @calculator.calculate('*')
       expect(result).to eq 2.0
     end

     it 'properly performs division between last two operands in the stack' do
       @calculator.operand_stack = [1.0, 2.0]
       result = @calculator.calculate('/')
       expect(result).to eq 0.5
     end
   end

   context 'when processing an operand input' do
     it 'properly stores the operand in operand stack' do
       @calculator.calculate('5')
       expect(@calculator.operand_stack).to eq [5.0]
     end
   end

   context 'when processing an invalid input' do
     it 'properly raises a suitable error message when an invalid input is detected' do
       expect do
         @calculator.calculate('++')
       end.to raise_error(described_class::INVALID_INPUT_FORMAT_ERROR)
     end
   end

  end

end
