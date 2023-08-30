/*
Copyright © 2023 EGBEWATT M. KOKOU	- kokou.egbewatt@gmail.com

*/
package generate

import (
	"fmt"
	"os"
    "runtime"

	"github.com/spf13/cobra"

	"aws_cdk_poetry/internal/generator"
	"aws_cdk_poetry/internal/utils"
)

// generateCmd represents the generate command
var GenerateCmd = &cobra.Command{
	Use:   "generate",
	Short: "Generate Poetry Managed CDK project",
	Long: `Sets up an aws cdk project for python with virtual environment and dependencies managed by poetry.`,
	
	Run: func(cmd *cobra.Command, args []string) {
		platform, _ := cmd.Flags().GetString("platform")
		name, _ := cmd.Flags().GetString("name")
		co := utils.CustomOutput{}
		co.Headline = "Setup"
		
		platformConfigs := generator.SetupPlatforms()
		platformConfig, ok := platformConfigs[platform]
		if !ok {
			fmt.Println("Platform not found:", platform)
			return
		}
		success, err := platformConfig.Generate(name, co)
		if err != nil {
			fmt.Println("Error:", err)
			return
		}
		if !success {
			fmt.Println("Generation failed.")
			os.Exit(1)
		}
	},
}

func init() {
	
	// detect OS for default build
	os := runtime.GOOS
	fmt.Println(os)

	// Persistent Flags 
	GenerateCmd.PersistentFlags().String("name", "TestProject", "name of the project")
	GenerateCmd.PersistentFlags().String("platform", os , "platform to generate for build")

}
