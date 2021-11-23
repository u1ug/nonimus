package main

// #include "test.h"
import "C"
import "unsafe"

func main() {
	cStr := C.CString("test string")
	C.sendMessage(cStr)
	defer C.free(unsafe.Pointer(cStr))
}
