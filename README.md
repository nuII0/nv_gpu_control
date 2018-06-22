# NvGpuControl
A ruby gem for configuring Nvidia GPUs on a Linux system.

## Notes
The program makes use of the `nvidia-smi` cli-tool to fetch and control the state of a GPU.
Per default, `nvidia-smi` requires adminstrative privileges for state-changing operations.

As a rule of thumb, essentially all GPUs since the year 2011 are supported (Tesla, Quadro, GeForce from Fermi and higher) by `nvidia-smi`.

## Usage
Add NvGpuControl as dependency and query installed GPUs.

```rb
require "NvGpuControl"

gpus = NvGpuControl.gpus

=> [[#<NvGpuControl::NvidiaGpu:0x0000564d8bee2f08
   @index=0,
   @name="GeForce GTX 1070",
   @uuid="GPU-88fc8d57-433e-4836-a678-06e6b6b7f24b">],
 [#<NvGpuControl::NvidiaGpu:0x0000564d8bee2f08
   @index=1,
   @name="GeForce GTX 1080 Ti",
   @uuid="GPU-3bd56316-82f6-4295-b50f-eaba0a38ff6f">]]
```

### Maximum Power Draw
You can fiddle with the maximum power draw of a GPU like this
```rb
gpu = gpus.first
gpu.power_limit.current
=> "180.00 W"

gpu.power_limit.set(watt: 190)
 INFO  NvGpuControl::Action::PowerLimit : Power limit for GPU 00000000:00:09.0 was set to 190.00 W from 180.00 W.
All done.
```

# License

This library is licensed under the MIT License.

