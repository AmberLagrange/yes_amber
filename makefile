Y_COUNT		?= 1
ITER 		?= 1

.PHONY: clean test yes

yes_amber_$(Y_COUNT)_$(ITER): yes_amber_$(Y_COUNT)_$(ITER).o
	ld $< -o $@

yes_amber_$(Y_COUNT)_$(ITER).o: yes_amber.s
	nasm -DY_COUNT=$(Y_COUNT) -DITER=$(ITER) -f elf64 yes_amber.s -o $@

test: $(YES_PROGS)
	./test.sh

clean:
	rm yes_amber_*
