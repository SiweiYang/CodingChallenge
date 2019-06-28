package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func check2(str string) bool {
	counter := make(map[string]int)
	for _, c := range str {
		char := string(c)
		counter[char] += 1
		//println(char)
		//println(counter[char])
	}

	for _, c := range counter {
		if c == 2 {
			return true
		}
	}

	return false
}

func check3(str string) bool {
	counter := make(map[string]int)
	for _, c := range str {
		char := string(c)
		counter[char] += 1
		//println(char)
		//println(counter[char])
	}

	for _, c := range counter {
		if c == 3 {
			return true
		}
	}

	return false
}

func expand(str string) []string {
	l := []string{}

	for i, v := range str {
		for j := 0; j < i; j++ {
			l[j] += string(v)
		}
		l = append(l, str[:i] + "*")
	}

	return l
}

func day2(inputFN string) {
	file, err := os.Open(inputFN)

	if err != nil {
		log.Fatalf("failed opening file: %s", err)
	}

	scanner := bufio.NewScanner(file)

	total2 := 0
	total3 := 0

	set := make(map[string]bool)
	for scanner.Scan() {
		str := scanner.Text()

		for _, s := range expand(str) {
			if set[s] {
				fmt.Printf("Duplicate found: %s\n", s)
			}

			set[s] = true
		}

		set[str] = true

		if check2(str) {
			total2 += 1
		}
		if check3(str) {
			total3 += 1
		}
	}
	fmt.Printf("Checksum: %d\n", total3 * total2)
	file.Close()

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}