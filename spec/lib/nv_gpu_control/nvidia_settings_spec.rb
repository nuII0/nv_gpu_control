RSpec.describe NvGpuControl::NvidiaSettings do

  describe ".run" do
    context "nvidia-settings binary missing from system" do
      it "raises" do
        allow_any_instance_of(NvGpuControl::Util::Shell)
          .to receive(:command?)
          .and_return(false)

        expect { described_class.run }.to raise_error(RuntimeError)
      end
    end

    context "without arguments" do
      let(:output) { "foo" }
      it "makes nvidia-settings system call" do
        allow_any_instance_of(NvGpuControl::Util::Shell)
          .to receive(:`)
          .and_return(output)
        expect(described_class.run).to eq(output)
      end
    end

    context "with argument" do
      let(:parameter) { "bar" }
      it "makes nvidia-settings system call with argument" do
        allow_any_instance_of(NvGpuControl::Util::Shell)
          .to receive(:`)
          .with(/#{parameter}/)
          .and_return("foo")
        expect(described_class.run("bar")).to eq("foo")
      end
    end
  end
end
