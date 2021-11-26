#ifdef __cplusplus
extern "C" {

#endif

	__declspec(dllexport) void addWithCuda(float A[][], float B[][], float C[][], unsigned int numBlocks, unsigned int threads);

#ifdef __cplusplus
}
#endif