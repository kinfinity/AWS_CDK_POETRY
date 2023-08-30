package utils

import (
	"fmt"
	"os"
	"io"

)

func VerifyScripts (dir string){
	if _, err := os.Stat(dir); os.IsNotExist(err) {
      fmt.Println(dir, "does not exist")
   	} else {
      fmt.Println("Script Directory", dir, "-> exists")
   	}

}

type CustomOutput struct{
	io.Writer
	Headline string
}

func (co CustomOutput) Write(p []byte) (int, error) {
	fmt.Println(co.Headline,":", string(p))
	return len(p), nil
}