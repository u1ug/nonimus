#include <cuda.h>

#include <stdio.h>
#include "kernel.h"


extern "C" {

    __global__ void addKernel(float A[1000][1000], float B[1000][1000], float C[1000][1000])
    {
        int i = blockIdx.x * blockDim.x + threadIdx.x;
        int j = blockIdx.y * blockDim.y + threadIdx.y;
            C[i][j] = A[i][j] + B[i][j];
    }
        
    void addWithCuda(float A[1000][1000], float B[1000][1000], float C[1000][1000], unsigned int numBlocks, unsigned int threads)
    {
        dim3 threadsPerBlock(1000, 1000);
        addKernel << <numBlocks, threadsPerBlock >> > (A, B, C);
    }
}

// Helper function for using CUDA to add vectors in parallel.
