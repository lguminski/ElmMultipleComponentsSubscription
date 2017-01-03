all: start_server

elm_compile:
	elm-make *.elm --yes --output elm.js

start_server: elm_compile
	python -m SimpleHTTPServer 8000
