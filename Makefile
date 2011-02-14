SRC_DIR = src
BUILD_DIR = build

DIR_PREFIX = .
DIST_DIR = ${DIR_PREFIX}/dist

SOURCES := $(patsubst ${SRC_DIR}/%.js, %, $(wildcard ${SRC_DIR}/*.js))

MINJAR = java -jar ${BUILD_DIR}/yuicompressor-2.4.2.jar

all: script standalone min
	@@echo "Script build complete."

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

min: script
	@@echo "Building minified scripts..."
	@@mkdir -p ${DIST_DIR}/min
	@@for f in ${SOURCES} ; do \
		${MINJAR} ${SRC_DIR}/$$f.js -o ${DIST_DIR}/min/$$f.min.js ; \
	done
	${MINJAR} ${DIST_DIR}/g.raphael.standalone.js -o ${DIST_DIR}/g.raphael.standalone.min.js ;

clean:
	@@echo "Removing Distribution directory:" ${DIST_DIR}
	@@rm -rf ${DIST_DIR}
