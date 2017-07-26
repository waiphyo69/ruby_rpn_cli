require 'spec_helper'

describe Interface  do

  before :each do
    @interface = described_class.new
  end

  describe '#prompt' do
    it 'raises not implemented error when .prompt is called' do
      expect do
        @interface.prompt
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#parse_input' do
    it 'raises not implemented error when .parse_input is called' do
      expect do
        @interface.parse_input
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#display' do
    it 'raises not implemented error when .display is called' do
      expect do
        @interface.display('1')
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#error' do
    it 'raises not implemented error when .error is called' do
      expect do
        @interface.error('some error')
      end.to raise_error(NotImplementedError)
    end
  end

end
