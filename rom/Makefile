popeye:
	cat \
	tpp2-c.7a \
	tpp2-c.7b \
	tpp2-c.7c \
	tpp2-c.7e \
	tpp2-v.1e \
	tpp2-v.1f \
	tpp2-v.1j \
	tpp2-v.1k \
	tpp2-v.5n \
	tpp2-v.7j \
	tpp2-c.5b \
	tpp2-c.5a \
	tpp2-c.4a \
	tpp2-c.3a \
	> jtpopeye.rom

clean:
	rm jtpopeye.rom

basic: 
	$(MAKE) -C ../modules/jtframe/asm/z80
	cat ../modules/jtframe/asm/z80/jtTinyBasic.o > jtpopeye.rom
	fillzeros.sh jtpopeye.rom 32
	cat \
	tpp2-v.1e \
	tpp2-v.1f \
	tpp2-v.1j \
	tpp2-v.1k \
	tpp2-v.5n \
	tpp2-v.7j \
	tpp2-c.5b \
	tpp2-c.5a \
	tpp2-c.4a \
	tpp2-c.3a \
	>> jtpopeye.rom	