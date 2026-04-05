repl:
	dune build
	./_build/default/src/repl.exe

code:
	dune build
	./_build/default/src/main.exe

clean:
	rm -rf _build/

.PHONY: repl code clean
