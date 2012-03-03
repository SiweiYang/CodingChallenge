all: HT-OPTIMIZED HT

HT-OPTIMIZED: src/HT-OPTIMIZED.hs
	ghc -O2 -threaded -rtsopts src/HT-OPTIMIZED.hs -o HT-OPTIMIZED

HT: src/HT.hs
	ghc -O2 -threaded -rtsopts src/HT.hs -o HT

clean:
	rm HT-OPTIMIZED HT