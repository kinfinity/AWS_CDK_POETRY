/*
Copyright © 2023 EGBEWATT M. KOKOU - kokou.egbewatt@gmail.com

*/
package cmd

import (
	"os"

	"github.com/spf13/cobra"

	"aws_cdk_poetry/cmd/generate"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "aws_cdk_poetry",
	Short: "Setup Poetry project for CDK ",
	Long: `The aws_cdk_poetry command is a utility designed to streamline the process of creating a new AWS Cloud Development Kit (CDK) project managed
with the Python package manager, Poetry. This command offers a cohesive way to initialize a CDK project and manage its virtual environment and 
dependencies using Poetry, a tool known for its capabilities in packaging and dependency management.`,
}

func AddSubCommandPalettes() {
	rootCmd.AddCommand(generate.GenerateCmd)
}

// Execute adds all child commands to the root command and sets flags appropriately.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.

	// rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.aws_cdk_poetry.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")

	AddSubCommandPalettes()

}


