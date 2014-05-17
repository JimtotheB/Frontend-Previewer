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
_ = require "lodash"
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
    port: config.server.port
    host: config.server.bind

gulp.task "reload", ()->
  locals =
    title: config.title
    scripts: _.without fs.readdirSync( path.join( __dirname, "server/assets/js" ) ), ".gitignore"
    styles:  _.without fs.readdirSync( path.join( __dirname, "server/assets/css" ) ), ".gitignore"
  gulp.src(src.jade)
  .pipe plumber()
  .pipe jade
    locals: locals
    pretty: true
  .pipe gulp.dest(dest.html)
  .pipe connect.reload()

gulp.task "cleanCss", ()->
  gulp.src("#{dest.css}/*.css")
  .pipe clean()

gulp.task "buildLess", ["cleanCss"], ()->
  gulp.src(src.less)
  .pipe plumber()
  .pipe less()
  .pipe gulp.dest(dest.css)


gulp.task "cleanJs", ()->
  gulp.src("#{dest.js}/*.js")
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
  watch(glob: "assets/less/**", emitOnGlob: false, ["buildLess"])

gulp.task "watchCoffee", ()->
  watch(glob: "assets/coffee/**", emitOnGlob: false, ["buildCoffee"])



gulp.task "default", ["watchJade", "watchLess", "watchCoffee", "watchAssets", "server", "reload"]