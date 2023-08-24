/*
Copyright © 2023 EGBEWATT M. KOKOU	- kokou.egbewatt@gmail.com

*/
package generate

import (
	"fmt"

	"github.com/spf13/cobra"
)

// generateCmd represents the generate command
var GenerateCmd = &cobra.Command{
	Use:   "generate",
	Short: "Generate Poetry Managed CDK project",
	Long: `Sets up an aws cdk project for python with virtual environment and dependencies managed by poetry.
For example:
$ aws_cdk_poetry generate <project_name>`,
	
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("generate called")
	},
}

func init() {

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// generateCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// generateCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
