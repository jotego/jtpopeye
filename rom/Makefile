all: popeye popeyeu.rom popeyef.rom skyskipr.rom

test_txt:
	z80asm ../ver/game/test_txt.s --output=test_txt.bin
	cat \
	test_txt.bin \
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

test_back:
	z80asm ../ver/game/test_back.s --output=test_back.bin
	cat \
	test_back.bin \
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

popeyeu.rom: 
	cat \
	popeyeu/7a \
	popeyeu/7b \
	popeyeu/7c \
	popeyeu/7e \
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
	> popeyeu.rom

popeyef.rom:
	cat \
	popeyef/tpp2-c_f.7a \
	popeyef/tpp2-c_f.7b \
	popeyef/tpp2-c_f.7c \
	popeyef/tpp2-c_f.7e \
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
	> popeyef.rom

skyskipr.rom:
	cat \
	tnx1-c.2a \
	tnx1-c.2b \
	tnx1-c.2c \
	tnx1-c.2d \
	tnx1-c.2e \
	tnx1-c.2f \
	tnx1-c.2g \
	tnx1-t.1e \
	tnx1-t.2e \
	tnx1-t.3e \
	tnx1-t.5e \
	tnx1-t.1e \
	tnx1-t.2e \
	tnx1-t.3e \
	tnx1-t.5e \
	tnx1-v.3h \
	tnx1-t.3j \
	tnx1-t.3a \
	tnx1-t.2a \
	tnx1-t.4a \
	tnx1-t.1a \
	> skyskipr.rom


clean:
	rm jtpopeye.rom skyskipr.rom popeyef.rom popeyeu.rom

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