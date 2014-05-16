# Generic gulp tools
gulp = require "gulp"
jade = require "gulp-jade"
gutil = require "gulp-util"
watch = require "gulp-watch"
plumber = require "gulp-plumber"
clean = require "gulp-clean"
less = require "gulp-less"

# JS/CS tools
coffee = require "gulp-coffee"

# Html tools

# Livereload server
connect = require "gulp-connect"

#Project specific Plugins

fs = require "fs"
path = require "path"
# Outside config
config = require("configurizer").getVariables(false)

src =
  coffee: "./assets/coffee/**/*"
  jade: "./assets/jade/index.jade"
  less: "./assets/less/main.less"

dest =
  html: "./server/"
  js: "./server/assets/js"
  css: "./server/assets/css"



gulp.task "server", ->
  connect.server
    root: ["./server"]
    livereload: true
    port: 9000
    host: "0.0.0.0"

gulp.task "reload", ()->
  locals =
    title: config.title
    scripts: fs.readdirSync( path.join( __dirname, "server/assets/js" ) )
    styles:  fs.readdirSync( path.join( __dirname, "server/assets/css" ) )
  gulp.src(src.jade)
  .pipe plumber()
  .pipe jade
    locals: locals
    pretty: true
  .pipe gulp.dest(dest.html)
  .pipe connect.reload()

gulp.task "cleanCss", ()->
  gulp.src(dest.css)
  .pipe clean()

gulp.task "buildLess", ["cleanCss"], ()->
  gulp.src(src.less)
  .pipe plumber()
  .pipe less()
  .pipe gulp.dest(dest.css)


gulp.task "cleanJs", ()->
  gulp.src(dest.js)
  .pipe clean()

gulp.task "buildCoffee", ["cleanJs"], ()->
  gulp.src(src.coffee)
  .pipe plumber()
  .pipe coffee()
  .pipe gulp.dest(dest.js)

gulp.task "watchJade", ()->
  watch(glob: "assets/jade/**/*", emitOnGlob: false, ["reload"])

gulp.task "watchAssets", ()->
  watch(glob: "server/assets/**/*", emitOnGlob: false, ["reload"])

gulp.task "watchLess", ()->
  watch(glob: "assets/less/**/*", emitOnGlob: false, ["buildLess"])

gulp.task "watchCoffee", ()->
  watch(glob: "assets/coffee/**/*", emitOnGlob: false, ["buildCoffee"])



gulp.task "default", ["watchJade", "watchLess", "watchCoffee", "watchAssets", "server"]