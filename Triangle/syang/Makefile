all: HT-OPTIMIZED HT-OPTIMIZED-V2 HT

HT-OPTIMIZED: src/HT-OPTIMIZED.hs
	ghc -O2 -threaded -rtsopts src/HT-OPTIMIZED.hs -o HT-OPTIMIZED

HT-OPTIMIZED-V2: src/HT-OPTIMIZED-V2.hs
	ghc -O2 -threaded -rtsopts src/HT-OPTIMIZED-V2.hs -o HT-OPTIMIZED-V2

HT: src/HT.hs
	ghc -O2 -threaded -rtsopts src/HT.hs -o HT

clean:
	rm HT-OPTIMIZED HT-OPTIMIZED-V2 HT
