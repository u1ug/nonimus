package main

/*
 #cgo CFLAGS: -I.
 #cgo LDFLAGS: -L. -lkernel
 #cgo windows LDFLAGS:-LC:/bin
 #cgo windows CFLAGS: -IC:/include
 #include "kernel.h"
*/
import "C"
import "fmt"

func addWithCuda(c [][]C.float, a [][]C.float, b [][]C.float, size int, widthThread int) {
	C.addWithCuda(c, a, b, C.uint(size), C.uint(widthThread))
}

func main() {
	//cStr := C.CString("test string")
	//C.sendMessage(cStr)
	//defer C.free(unsafe.Pointer(cStr))

	const x = 1000
	const y = 1000
	a := make([][]C.float, x)
	b := make([][]C.float, x)
	c := make([][]C.float, x)
	for i := 0; i < x; i++ {
		a[i] = make([]C.float, y)
		b[i] = make([]C.float, y)
		for j := 0; j < y; j++ {
			a[i][j] = C.float(1.3923)
			b[i][j] = C.float(2.4930)
		}
	}

	// Add vectors in parallel.
	addWithCuda(c, a, b, x, y)

	fmt.Println(float64(a[9][0]))
	fmt.Println(float64(b[9][0]))
	fmt.Println(float64(c[9][0]))
}
