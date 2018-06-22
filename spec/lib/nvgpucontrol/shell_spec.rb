# frozen_string_literal: true

RSpec.describe NvGpuControl::Util::Shell do
  let(:described_module){ NvGpuControl::Util::Shell }
  let(:described_class) do
    Class.new do
      include NvGpuControl::Loggable
      include NvGpuControl::Util::Shell
    end
  end

  subject{ described_class.new }
  let(:echo_call){ "#{`which echo`.strip} Okay" }
  let(:true_call){ `which true`.strip }
  let(:false_call){ `which false`.strip }

  describe '#system' do
    it 'is overriden' do
      expect(subject.method(:system).owner).to be described_module
    end

    context 'normal invocation' do
      context 'on error' do
        it 'raises an Error' do
          expect{ subject.system(false_call) }.to raise_error described_module::Error
        end
      end

      it 'calls the shell' do
        expect(subject.system(true_call)).to be true
      end
    end
  end

  describe '#`' do
    it 'is overriden' do
      expect(subject.method(:`).owner).to be described_module
    end

    context 'normal invocation' do
      context 'on error' do
        it 'raises an Error' do
          expect{ subject.`(false_call) }.to raise_error described_module::Error # `
        end
      end

      it 'calls the shell' do
        expect(subject.`(echo_call)).to match(/Okay/) # `
      end
    end
  end
end
