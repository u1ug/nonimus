#include <cuda.h>

#include <stdio.h>
#include "kernel.h"


extern "C" {

    __global__ void addKernel(float A[10000][10000], float B[10000][10000], float C[10000][10000])
    {
        int i = blockIdx.x * blockDim.x + threadIdx.x;
        int j = blockIdx.y * blockDim.y + threadIdx.y;
        if(i < 1000 && j < 1000) C[i][j] = A[i][j] + B[i][j];
    }
        
    void addWithCuda(float A[10000][10000], float B[10000][10000], float C[10000][10000], unsigned int numBlocks, unsigned int threads)
    {
        dim3 blockSize;
        dim3 gridSize;
        int threadNum;

        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);

        threadNum = 1024;
        blockSize = dim3(threadNum, 1, 1);
        gridSize = dim3(numCols/threadNum+1, numRows, 1);
        addKernel << <numBlocks, threadsPerBlock >> > (A, B, C);
    }
}

// Helper function for using CUDA to add vectors in parallel.
