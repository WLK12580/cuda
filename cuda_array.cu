#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdio.h>

#include <array>
#include <iostream>
__global__ void kernel_func(int *arr13, int *arr11, int *arr12) {  //__global__ 表示核函数在GPU上执行
  int idx = threadIdx.x;  //threadIdx指的是线程的索引
  arr13[idx] = arr11[idx] * arr12[idx];
}
int main() {
  int arr1[3] = {1, 3, 5};
  int arr2[3] = {2, 4, 6};
  int arr3[3];
  int *arr11 = nullptr; //device变量
  int *arr12 = nullptr;
  int *arr13 = nullptr;
  cudaMalloc((void **)&arr13, sizeof(int) * 3); //给设备变量分配内存
  cudaMalloc((void **)&arr11, sizeof(int) * 3);
  cudaMalloc((void **)&arr12, sizeof(int) * 3);
  cudaMemcpy(arr11, arr1, sizeof(int) * 3, cudaMemcpyHostToDevice); //从主机复制数据到GPU
  cudaMemcpy(arr12, arr2, sizeof(int) * 3, cudaMemcpyHostToDevice);
  cudaMemcpy(arr13, arr3, sizeof(int) * 3, cudaMemcpyHostToDevice);
  kernel_func<<<1, 3>>>(arr13, arr11, arr12); //分配一个块三个线程，同一个块中的线程是同步的

  cudaError_t  cudaStatus = cudaMemcpy(arr3, arr13, 3 * sizeof(int), cudaMemcpyDeviceToHost); //将计算结果返回到主机
  if(cudaStatus != cudaSuccess){
    std::cout<<"error\n";
    return 0;
  }
  for (int i = 0; i < 3; i++) {
    printf("arr13=%d\n", arr3[i]);
  }
  cudaFree(arr1);
  cudaFree(arr2);
  cudaFree(arr3);
  cudaDeviceReset();
  return 0;
}
