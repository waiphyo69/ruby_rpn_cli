require 'spec_helper'

RSpec.describe 'Play', :type => :aruba do
  def aggregated_output(content_array = [])
    initial_message + content_array.map{|content| prompt_message + content}.inject(:+).to_s +
    prompt_message + quit_message
  end

  def colorized_content(content)
    content.colorize(content_color)
  end

  def colorized_error(error)
    ("Error: " + error).colorize(error_color)
  end

  let(:content_color) { :blue }
  let(:error_color) { :red }
  let(:initial_message) { colorized_content(Engine::WELCOME_MESSAGE + Engine::HELP_MESSAGE) }
  let(:help_message) { colorized_content(Engine::HELP_MESSAGE.colorize(content_color)) }
  let(:prompt_message) { CliInterface::INITIAL_PROMPT }
  let(:quit_message) { colorized_content(Engine::SHUTDOWN_MESSAGE) }
  let(:insufficient_operand_error_message) { colorized_error(RpnCalculator::INSUFFICIENT_OPERAND_ERROR) }
  let(:invalid_input_error_message) { colorized_error(RpnCalculator::INVALID_INPUT_FORMAT_ERROR) }

  before :each do
    cd('../..')
    run("ruby #{Dir.getwd}/play.rb")
  end

  it 'initially displays welcome message and help message on q' do
    expected_output = aggregated_output
    type('q')
    #make sure program output is caught by waiting 1 second
    sleep 1
    #output from cmd adds extra new lines to string thus the need for swapping line breaks
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'displays help message when h is entered' do
    expected_output = aggregated_output([help_message])
    type('h')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'displays floated number when a number is entered' do
    expected_output = aggregated_output([colorized_content('1.0')])
    type('1')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'displays the stack when s is entered' do
    expected_output = aggregated_output([colorized_content('1.0'),
      colorized_content('2.0'), colorized_content('1.0 2.0')])
    type('1')
    type('2')
    type('s')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'clears the stack and displays empty stack when r is entered' do
    expected_output = aggregated_output([colorized_content('1.0'),
      colorized_content('2.0'), colorized_content('')])
    type('1')
    type('2')
    type('r')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'calculates properly when an operator is entered and there are enough operands' do
    expected_output = aggregated_output([colorized_content('1.0'),
      colorized_content('2.0'), colorized_content('3.0')])
    type('1')
    type('2')
    type('+')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'calculates properly when multiple operators are entered and there are enough operands' do
    expected_output = aggregated_output([colorized_content('1.0'),
      colorized_content('2.0'), colorized_content('3.0'), colorized_content('5.0'),
      colorized_content('-4.0')])
    type('1')
    type('2')
    type('3')
    type('+')
    type('-')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'displays a proper error message when there are not enough operands' do
    expected_output = aggregated_output([insufficient_operand_error_message])
    type('+')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'displays a proper error message when the input is invalid' do
    expected_output = aggregated_output([invalid_input_error_message])
    type('+++')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end

  it 'retains the stack and recovers gracefully for further operations when error' do
    expected_output = aggregated_output([colorized_content('1.0'),
      colorized_content('2.0'), invalid_input_error_message, colorized_content('0.5')])
    type('1')
    type('2')
    type('+++')
    type('/')
    type('q')
    sleep 1
    expect(last_command_started.output.gsub("\n", '')).to eq expected_output.gsub("\n", '')
  end
end
