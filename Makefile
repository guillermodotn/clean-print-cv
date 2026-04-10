.PHONY: build watch thumbnail clean

# Build the CV PDF
build:
	typst compile cv.typ

# Watch for changes and recompile
watch:
	typst watch cv.typ

# Generate side-by-side thumbnail (both pages next to each other)
# Each page gets a drop shadow on a light gray background.
# Requires: typst, ImageMagick (magick or convert)
thumbnail: build
	typst compile cv.typ thumbnail-{n}.png --ppi 300
	magick \
		\( thumbnail-1.png \
		   \( +clone -background '#00000040' -shadow 80x8+4+4 \) \
		   +swap -background none -layers merge +repage \) \
		\( thumbnail-2.png \
		   \( +clone -background '#00000040' -shadow 80x8+4+4 \) \
		   +swap -background none -layers merge +repage \) \
		-background '#f0f0f0' +smush 60 \
		-bordercolor '#f0f0f0' -border 40 \
		thumbnail.png
	rm -f thumbnail-1.png thumbnail-2.png
	@echo "Created thumbnail.png"

# Clean build artifacts
clean:
	rm -f cv.pdf thumbnail.png thumbnail-*.png
