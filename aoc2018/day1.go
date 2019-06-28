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
	var raw_list []int
	for scanner.Scan() {
		n, _ := strconv.Atoi(scanner.Text())
		raw_list = append(raw_list, n)

		total += n
	}
	file.Close()

	fmt.Printf("The resulting frequency is %d\n", total)

	list := make(chan int, len(raw_list))
	for _, n := range raw_list {
		list <- n
	}

	total = 0
	visited := make(map[int]bool)
	visited_twice := false
	visited[total] = true

	for !visited_twice {
		n := <- list
		total += n
		//fmt.Println(n)
		if !visited_twice && visited[total] {
			visited_twice = true
			fmt.Printf("Reached %d twice first!\n", total)
			//break
		}
		visited[total] = true

		list <- n
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}