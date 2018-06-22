# frozen_string_literal: true

RSpec.describe NvGpuControl::Action::PowerLimit do

  subject{ described_class.new(gpu_index: 1337) }

  describe "#set" do
    context "new value is bogus" do
      let (:start_value) { 0 }
      let (:new_value_expected) { 1 }
      let (:new_value_returned) { 2 }
      it "raises" do
        allow(NvGpuControl::NvidiaSmi)
          .to receive(:run)
          .and_return(start_value, new_value_returned)
        expect{subject.set(watt: new_value_expected) }.to raise_error(NvGpuControl::Action::VerificationError)
      end
    end

    context "new value is correct" do
      let (:start_value) { 0 }
      let (:new_value_expected) { 1 }
      let (:new_value_returned) { new_value_expected }
      it "does not raise" do
        allow(NvGpuControl::NvidiaSmi)
          .to receive(:run)
          .and_return(start_value, new_value_returned)
        expect{subject.set(watt: new_value_expected) }.not_to raise_error
      end
    end
  end
end
