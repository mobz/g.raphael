## How to build gRaphaël

In the main directory, type:

    make

To start over and remove all the distribution files, use:
  
    make clean

## What is created

### 4 versions of g.raphael are built

1. Unmodifed original source version.
       Located in the dist/src directory
2. Minified source versions.
       Located in the dist/min directory
3. An all-in-one. Which includes all chart types and the base raphael file
       Located at dist/g.raphael.standalone.js
4. A Minified all-in-one, including all files and minified.
       Located at dist/g.raphael.standalone.min.js 

### HTML Documentation

In addition html documentation is created using [kennyshen's g.raphael fork](https://github.com/kennyshen/g.raphael) and the [adc-markdown-theme from drewyeaton](https://github.com/drewyeaton/adc-markdown-theme) 
       Located at dist/docs
