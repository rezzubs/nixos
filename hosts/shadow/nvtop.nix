# nvtop pulls in a bunch of proprietary CUDA libraries just to report GPU stats.
{pkgs, ...}: {
  nixpkgs.config.allowUnfreePackages = [
    "libnpp"
    "libcusparse"
    "libnvjitlink"
    "libcusolver"
    "libcurand"
    "libcufft"
    "cuda-merged"
    "cuda_cuobjdump"
    "cuda_gdb"
    "cuda_nvcc"
    "cuda_nvdisasm"
    "cuda_nvprune"
    "cuda_cccl"
    "cuda_cudart"
    "cuda_cupti"
    "cuda_cuxxfilt"
    "cuda_nvml_dev"
    "cuda_nvrtc"
    "cuda_nvtx"
    "cuda_profiler_api"
    "cuda_sanitizer_api"
    "libcublas"
  ];

  environment.systemPackages = [pkgs.nvtopPackages.nvidia];
}
