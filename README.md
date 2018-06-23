# NvGpuControl
A ruby gem for configuring Nvidia GPUs on Linux Systems.

## Notes
The program makes use of the cli-tools `nvidia-smi` and `nvidia-settings` to fetch and control the state of a GPU.
Per default, `nvidia-smi` requires adminstrative privileges for state-changing operations.
`nvidia-settings` requires an active Xorg-session for the targeted GPU. 
If you want to change clocks, the according CoolBit option must be configured for Xorg.

As a rule of thumb, essentially all GPUs since the year 2011 are supported (Tesla, Quadro, GeForce from Fermi and higher) by `nvidia-smi`.

## Usage
Add NvGpuControl as dependency and query installed GPUs.

```rb
require "nv_gpu_control"

gpus = NvGpuControl.gpus

=> [[#<NvGpuControl::NvidiaGpu:0x0000564d8bee2f08
   @index=0,
   @name="GeForce GTX 1070",
   @uuid="GPU-88fc8d57-433e-4836-a678-06e6b6b7f24b">],
   [#<NvGpuControl::NvidiaGpu:0x00003244eadd2f13
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
=> "INFO  NvGpuControl::Action::PowerLimit : Power limit for GPU 00000000:00:09.0 was set to 190.00 W from 180.00 W."
```
### Core Clock Settings
To over- or underclock the GPUs core clock for a certain power level use this.
```rb
gpu.core_clock_offset.current(power_level: 3)                                                                                               
=> "0 Mhz"

gpu.core_clock_offset.set(power_level: 3, mhz: -10)                                                                                         
=> "INFO  NvGpuControl::Action::CoreClockOffset : assigned value -10."
```
### Memory Transfer Clock Settings
Settings for memory transer clock goes the same.
```rb
gpu.memory_transfer_offset.current(power_level: 3)                                                                                               
=> "0 Mhz"

gpu.memory_transfer_offset.set(power_level: 3, mhz: 10)                                                                                         
=> "INFO  NvGpuControl::Action::CoreClockOffset : assigned value 10."
```

# License

This library is licensed under the MIT License.

