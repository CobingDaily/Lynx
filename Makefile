repl:
	dune build
	./_build/default/repl.exe

code:
	dune build
	./_build/default/main.exe

clean:
	rm -rf _build/

.PHONY: repl code clean
