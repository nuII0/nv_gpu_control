RSpec.describe NvGpuControl do

  describe ".gpus" do
    context "no gpus installed" do
      it "returns empty array" do
        allow(NvGpuControl::NvidiaSmi)
          .to receive(:run)
          .and_return("")
        expect(described_class.gpus).to be_empty
      end
    end

    context "unparseable output" do
      it "raises" do
        allow(NvGpuControl::NvidiaSmi)
          .to receive(:run)
          .and_return("rubbish")
        expect{described_class.gpus}.to raise_error(RuntimeError)
      end
    end

    context "parseable output" do
      let (:index) { 0 }
      let (:name) { "GeForce GTX 1060" }
      let (:uuid) { "GPU-84dfcra7-0eb7-8ea3-0017-99752fad1d6b" }

      it "returns gpu" do
        allow(NvGpuControl::NvidiaSmi)
          .to receive(:run)
          .and_return("GPU #{index}: #{name} (UUID: #{uuid})")
        gpu = described_class.gpus.first

        expect(gpu.index).to eq(index)
        expect(gpu.name).to eq(name)
        expect(gpu.uuid).to eq(uuid)
      end

      it "returns gpus" do
        allow(NvGpuControl::NvidiaSmi)
          .to receive(:run)
          .and_return("GPU #{index}: #{name} (UUID: #{uuid})
                       GPU #{index}: #{name} (UUID: #{uuid})")

        expect(described_class.gpus.size).to eq(2)
      end
    end
  end
end
