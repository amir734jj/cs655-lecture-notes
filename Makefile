.PHONY:  default

# default note that will appear when we use: `make`
default:
	@echo "make [build|publish]"

# `make lab12.build`	// builds a specific lab into PDF
%.build:
	./scripts/build.sh $*

# `make build`				// builds all labs into PDF
build:
	./scripts/build.sh

# `make publish` 			// publish labs into your github
publish:
	./scripts/publish.sh

# `make lab10.new`		// create a new lab
%.new:
	mkdir -p $*;
	echo "---\n\
marp: true\n\
---\n\
\
# Title!\
" > $*/note.marp.md

# `make clean`				// delete all PDF files so we can rebuild them
clean:
	rm -i lab*/*.pdf >/dev/null