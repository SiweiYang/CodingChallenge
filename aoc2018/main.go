package main

import (
	"fmt"
	"log"
	"os"
	"github.com/urfave/cli"
)

func main() {
	app := cli.NewApp()

	app.Action = func(c *cli.Context) error {
		if c.Args().Get(0) == "day1" {
			fmt.Printf("this is day1\n")
			inputFN := c.Args().Get(1)

			day1(inputFN)
		}

		return nil
	}

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}
