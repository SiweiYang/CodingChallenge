package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func day1(inputFN string) {
	file, err := os.Open(inputFN)

	if err != nil {
		log.Fatalf("failed opening file: %s", err)
	}

	total := 0

	scanner := bufio.NewScanner(file)
	var list []int
	for scanner.Scan() {
		n, _ := strconv.Atoi(scanner.Text())

		total += n
		list = append(list, n)
	}
	file.Close()

	fmt.Printf("The resulting frequency is %d\n", total)

	total = 0
	visited := make(map[int]bool)
	visited_twice := false
	visited[total] = true
	for {
		n := list[0]
		list = list[1:]
		list = append(list, n)

		total += n
		//fmt.Println(visited[total])
		if !visited_twice && visited[total] {
			visited_twice = true
			fmt.Printf("Reached %d twice first!\n", total)
			break
		}
		visited[total] = true
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}