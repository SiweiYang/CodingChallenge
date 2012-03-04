#!/usr/bin/env bash
echo Start... > result
echo [0004,100,0400] >> result
time ./HT-OPTIMIZED 0004 0100 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 0104 0200 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 0204 0300 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 0304 0400 +RTS -K100000000 -RTS >> result
echo [0400] >> result

echo [0404,100,0700] >> result
time ./HT-OPTIMIZED 0404 0500 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 0504 0600 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 0604 0700 +RTS -K100000000 -RTS >> result
echo [0700] >> result

echo [0704,100,1000] >> result
time ./HT-OPTIMIZED 0704 0800 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 0804 0900 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 0904 1000 +RTS -K100000000 -RTS >> result
echo [1000] >> result

echo [1004,100,1300] >> result
time ./HT-OPTIMIZED 1004 1100 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 1104 1200 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 1204 1300 +RTS -K100000000 -RTS >> result
echo [1300] >> result

echo [1304,100,1600] >> result
time ./HT-OPTIMIZED 1304 1400 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 1404 1500 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 1504 1600 +RTS -K100000000 -RTS >> result
echo [1600] >> result

echo [1604,100,1900] >> result
time ./HT-OPTIMIZED 1604 1700 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 1704 1800 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 1804 1900 +RTS -K100000000 -RTS >> result
echo [1900] >> result

echo [1904,100,2200] >> result
time ./HT-OPTIMIZED 1904 2000 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 2004 2100 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 2104 2200 +RTS -K100000000 -RTS >> result
echo [2200] >> result

echo [2204,100,2500] >> result
time ./HT-OPTIMIZED 2204 2300 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 2304 2400 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 2404 2500 +RTS -K100000000 -RTS >> result
echo [2500] >> result

echo [2504,100,2600] >> result
time ./HT-OPTIMIZED 2504 2600 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 2604 2700 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 2704 2800 +RTS -K100000000 -RTS >> result
echo [2800] >> result

echo [2804,100,3000] >> result
time ./HT-OPTIMIZED 2804 2900 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 2904 3000 +RTS -K100000000 -RTS >> result
echo [3000] >> result

echo [3004,100,3200] >> result
time ./HT-OPTIMIZED 3004 3100 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 3104 3200 +RTS -K100000000 -RTS >> result
echo [3200] >> result

echo [3204,100,3400] >> result
time ./HT-OPTIMIZED 3204 3300 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 3304 3400 +RTS -K100000000 -RTS >> result
echo [3400] >> result

echo [3404,100,3600] >> result
time ./HT-OPTIMIZED 3404 3500 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 3504 3600 +RTS -K100000000 -RTS >> result
echo [3600] >> result

echo [3604,100,3800] >> result
time ./HT-OPTIMIZED 3604 3700 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 3704 3800 +RTS -K100000000 -RTS >> result
echo [3800] >> result

echo [3804,100,4000] >> result
time ./HT-OPTIMIZED 3804 3900 +RTS -K100000000 -RTS >> result &
time ./HT-OPTIMIZED 3904 4000 +RTS -K100000000 -RTS >> result
echo [4000] >> result

