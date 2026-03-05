alias default := build

build:
    mkdir -p colors
    veneer build src colors

clean:
    rm -rf colors
