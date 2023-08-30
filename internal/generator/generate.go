package generator

import (
	"os/exec"
	"fmt"
	"path/filepath"
	"bytes"
	"strings"
	"os"

	"aws_cdk_poetry/internal/utils"

)

type PlatformConfig struct {
	Arch        string
	OS          string
	ScriptPath  string
	Ext 		string
}

func (config PlatformConfig) Generate(name string, co utils.CustomOutput) (bool, error) {
	// 
	utils.VerifyScripts(config.ScriptPath)
	// handle different architectures later
	var scriptFile = filepath.Join(config.ScriptPath, "generate_project"+config.Ext)
	fmt.Fprintf(co, scriptFile)

	absPath, err := filepath.Abs(scriptFile)
	if err != nil {
		return false, err
	}
	fmt.Fprintf(co, absPath)

	switch config.OS {
		case "Windows":
			fmt.Fprintf(co, "This is Windows")
		case "Linux":
			fmt.Fprintf(co, "This is Linux")
			co.Headline = "Generate in Linux"
			_, err := execBash(absPath, name, co)
			if err != nil {
				return false, err
			}
		case "Darwin":
			fmt.Fprintf(co, "This is MacOs")
		default:
			fmt.Fprintf(co, "Unknown operating system")
			os.Exit(1)
	}

	fmt.Fprintln(co, name, "-> project generation completed successfully!")
	return true, nil
}

func execPowershell() (bool, error){
	return false, nil
}

func execBash(absPath string, name string, co utils.CustomOutput)(bool, error){
	// 
	command := "bash"
	args := []string{absPath, name, "yes"}
	fmt.Fprintf(co,"Executing command:", strings.Join(append([]string{command}, args...), " "))

	// Set the working directory
	workingDir, err := os.Getwd()
	if err != nil {
		fmt.Fprintf(co,"Error getting current directory:", err)
		return false, err
	}
	fmt.Fprintf(co,"Getting current directory:", workingDir)

	cmd := exec.Command(command, args...)
	cmd.Dir = workingDir
	// Create buffer to capture output
	var stdoutBuf, stderrBuf bytes.Buffer
	cmd.Stdout = &stdoutBuf
	cmd.Stderr = &stderrBuf
	err = cmd.Start()
	if err != nil {
		fmt.Fprintf(co,"Error starting command:", err)
		return false, err
	}
	err = cmd.Wait()
	// Print captured output
	fmt.Fprintf(co,"Standard Output:", stdoutBuf.String())
	fmt.Fprintf(co,"Standard Error:", stderrBuf.String())
	// fmt.Fprint(co, out)
	if err != nil {
		return false, err
	}
	return true, nil
}

func SetupPlatforms() map[string]*PlatformConfig {
	WindowsPlatformConfig := PlatformConfig{
		Arch:       "amd64",
		OS:         "Windows",
		ScriptPath: "scripts/windows",
		Ext: 		".ps1",
	}

	LinuxPlatformConfig := PlatformConfig{
		Arch:       "amd64",
		OS:         "Linux",
		ScriptPath: "scripts/linux",
		Ext: 		".sh",
	}

	MacPlatformConfig := PlatformConfig{
		Arch:       "amd64",
		OS:         "Darwin",
		ScriptPath: "scripts/macos",
		Ext: 		".sh",
	}

	// Map platform name to config
	return map[string]*PlatformConfig{
		"windows": &WindowsPlatformConfig,
		"linux":   &LinuxPlatformConfig,
		"darwin":     &MacPlatformConfig,
	}
}

type Generator interface {
	Generate(co utils.CustomOutput) (bool, error)
}
