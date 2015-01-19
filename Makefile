# I don't know how to write make files. Sorry...
all:
	elm-make src/bubbles-fps.elm --output=examples/bubbles-fps.html
	elm-make src/bubbles-frame.elm --output=examples/bubbles-frame.html
	elm-make src/counter.elm --output=examples/counter.html

clean:
	rm examples/*