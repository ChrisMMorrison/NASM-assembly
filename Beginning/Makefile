p = 

$(p): $(p).o
	@ld -o  $(p) $(p).o
	@chmod u+x $(p)
	@./$(p)
	@rm $(p).o $(p)

$(p).o: $(p).asm
	@nasm -felf64 $(p).asm -o $(p).o
