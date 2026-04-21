.PHONY: build watch thumbnail clean publish

# Build the CV PDF
build:
	typst compile cv.typ

# Watch for changes and recompile
watch:
	typst watch cv.typ

# Generate thumbnail from template data (as initialized by typst init).
# Each page gets a drop shadow on a light gray background.
# Requires: typst, ImageMagick (magick or convert)
thumbnail:
	typst compile template/main.typ thumbnail-{n}.png --ppi 300
	@pages=$$(ls thumbnail-*.png 2>/dev/null | wc -l); \
	if [ "$$pages" -eq 1 ]; then \
		magick \
			\( thumbnail-1.png \
			   \( +clone -background '#00000040' -shadow 80x8+4+4 \) \
			   +swap -background none -layers merge +repage \) \
			-background '#f0f0f0' \
			-bordercolor '#f0f0f0' -border 40 \
			thumbnail.png; \
	else \
		magick \
			\( thumbnail-1.png \
			   \( +clone -background '#00000040' -shadow 80x8+4+4 \) \
			   +swap -background none -layers merge +repage \) \
			\( thumbnail-2.png \
			   \( +clone -background '#00000040' -shadow 80x8+4+4 \) \
			   +swap -background none -layers merge +repage \) \
			-background '#f0f0f0' +smush 60 \
			-bordercolor '#f0f0f0' -border 40 \
			thumbnail.png; \
	fi
	rm -f thumbnail-1.png thumbnail-2.png
	@echo "Created thumbnail.png"

# Copy package files to a typst/packages fork for publishing.
# Usage: make publish DEST=/path/to/packages-fork
publish:
ifndef DEST
	$(error DEST is required. Usage: make publish DEST=/path/to/packages-fork)
endif
	@mkdir -p $(DEST)/packages/preview/clean-print-cv/0.1.0/template
	cp typst.toml        $(DEST)/packages/preview/clean-print-cv/0.1.0/
	cp cv-template.typ   $(DEST)/packages/preview/clean-print-cv/0.1.0/
	cp LICENSE           $(DEST)/packages/preview/clean-print-cv/0.1.0/
	cp README.md         $(DEST)/packages/preview/clean-print-cv/0.1.0/
	cp thumbnail.png     $(DEST)/packages/preview/clean-print-cv/0.1.0/
	cp template/main.typ $(DEST)/packages/preview/clean-print-cv/0.1.0/template/
	cp template/cv-data.yaml $(DEST)/packages/preview/clean-print-cv/0.1.0/template/
	cp template/LICENSE  $(DEST)/packages/preview/clean-print-cv/0.1.0/template/
	@echo "Copied to $(DEST)/packages/preview/clean-print-cv/0.1.0/"

# Clean build artifacts
clean:
	rm -f cv.pdf thumbnail.png thumbnail-*.png
