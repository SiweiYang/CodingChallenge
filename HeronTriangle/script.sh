#!/usr/bin/env bash
echo Start... > result
time ./HT-OPTIMIZED 0004 0400 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 0404 0800 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 0804 1000 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 1004 1200 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 1204 1400 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 1404 1600 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 1604 1800 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 1804 2000 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 2004 2100 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 2104 2200 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 2204 2300 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 2304 2400 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 2404 2500 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 2504 2600 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 2604 2700 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 2704 2800 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 2804 2900 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 2904 3000 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 3004 3100 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 3104 3200 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 3204 3300 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 3304 3400 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 3404 3500 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 3504 3600 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 3604 3700 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 3704 3800 +RTS -K100000000 -N2 -RTS >> result
time ./HT-OPTIMIZED 3804 3900 +RTS -K100000000 -N2 -RTS >> result &
time ./HT-OPTIMIZED 3904 4000 +RTS -K100000000 -N2 -RTS >> result

