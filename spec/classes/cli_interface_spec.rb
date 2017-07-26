require 'spec_helper'
require 'stringio'
require 'colorize'

describe CliInterface  do

  before :each do
    @content_color = :blue
    @error_color = :red
    @cli_interface = described_class.new(@content_color, @error_color)
  end

  describe '#prompt' do
    it 'properly prints initial prompt' do
      expect do
        @cli_interface.prompt
      end.to output(described_class::INITIAL_PROMPT).to_stdout
    end
  end

  describe '#parse_input' do
    before do
      $stdin = StringIO.new("Some input\n")
    end
    after do
      $stdin = STDIN
    end

    it 'properly takes a standard input and chomps it' do
      expect(@cli_interface.parse_input).to eq 'Some input'
    end
  end

  describe '#display' do
    it 'displays the content provided with proper color' do
      expect do
        @cli_interface.display('some content')
      end.to output('some content'.colorize(@content_color) + "\n").to_stdout
    end
  end

  describe '#error' do
    it 'displays the error message provided with proper color' do
      expect do
        @cli_interface.error('some error message')
      end.to output('Error: some error message'.colorize(@error_color) + "\n").to_stdout
    end
  end

end
