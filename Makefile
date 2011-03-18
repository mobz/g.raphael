DIR_PREFIX = .

SRC_DIR = ${DIR_PREFIX}/src
BUILD_DIR = ${DIR_PREFIX}/build
DOCS_DIR = ${DIR_PREFIX}/docs
DIST_DIR = ${DIR_PREFIX}/dist
MD_THEME = ${BUILD_DIR}/markdown-theme

SOURCES := $(patsubst ${SRC_DIR}/%.js, %, $(wildcard ${SRC_DIR}/*.js))
DOC_SOURCES := $(patsubst ${DOCS_DIR}/%.markdown, %, $(wildcard ${DOCS_DIR}/*.markdown))

MINJAR = java -jar ${BUILD_DIR}/yuicompressor-2.4.2.jar
MARKDOWN = perl ${BUILD_DIR}/Markdown_1.0.1/Markdown.pl

all: script standalone min docs examples
	@@echo "Script build complete."

examples: script standalone min
	@@echo "Copying minified standalone to examples"
	@@cp ${DIST_DIR}/g.raphael.standalone.min.js examples/lib

docs: script
	@@echo "Building documentation..."
	@@mkdir -p ${DIST_DIR}/docs
	@@for f in ${DOC_SOURCES} ; do \
  	cat ${MD_THEME}/header.html > ${DIST_DIR}/docs/$$f.html ; \
		${MARKDOWN} ${DOCS_DIR}/$$f.markdown >> ${DIST_DIR}/docs/$$f.html ; \
		cat ${MD_THEME}/footer.html >> ${DIST_DIR}/docs/$$f.html ; \
	done
	@@cp -r ${MD_THEME}/include/* ${DIST_DIR}/docs

script:
	@@echo "Copying scripts..."
	@@mkdir -p ${DIST_DIR}
	@@mkdir -p ${DIST_DIR}/src
	@@for f in ${SOURCES} ; do \
		cp ${SRC_DIR}/$$f.js ${DIST_DIR}/src ; \
	done

standalone:
	@@echo "Creating standalone script..."
	@@cat ${SRC_DIR}/raphael.js ${SRC_DIR}/g.raphael.js ${SRC_DIR}/g.bar.js ${SRC_DIR}/g.dot.js ${SRC_DIR}/g.line.js ${SRC_DIR}/g.pie.js > ${DIST_DIR}/g.raphael.standalone.js ;

min: script standalone
	@@echo "Building minified scripts..."
	@@mkdir -p ${DIST_DIR}/min
	@@for f in ${SOURCES} ; do \
		${MINJAR} ${SRC_DIR}/$$f.js -o ${DIST_DIR}/min/$$f.min.js ; \
	done
	${MINJAR} ${DIST_DIR}/g.raphael.standalone.js -o ${DIST_DIR}/g.raphael.standalone.min.js ;

clean:
	@@echo "Removing Distribution directory:" ${DIST_DIR}
	@@rm -rf ${DIST_DIR}
