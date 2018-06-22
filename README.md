# nvgpucontrol
A ruby gem for configuring Nvidia GPUs on a Linux system.

## Quick Start
Add nvgpucontrol as dependency and query existing GPUs.

```rb
require "nvgpucontrol"

gpus = Nvgpucontrol.gpus

=> [[#<Nvgpucontrol::NvidiaGpu:0x0000564d8bee2f08
   @index=0,
   @name="GeForce GTX 1070",
   @uuid="GPU-88fc8d57-433e-4836-a678-06e6b6b7f24b">],
 [#<Nvgpucontrol::NvidiaGpu:0x0000564d8bee2f08
   @index=1,
   @name="GeForce GTX 1080 Ti",
   @uuid="GPU-3bd56316-82f6-4295-b50f-eaba0a38ff6f">]]
```

You can fiddle with the maximum power draw of a GPU like this
```rb
gpu.maximum_voltage.current
=> "180.00 W"

gpu.maximum_voltage.set(watt: 190)
 INFO  Nvgpucontrol::Action::MaximumVoltage : Power limit for GPU 00000000:00:09.0 was set to 190.00 W from 180.00 W.
All done.
```
