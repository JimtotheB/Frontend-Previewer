class FeDebugger
  constructor: ()->
    @hidden = false
    @container = $("""<div class="debugContainer"></div>""")
    @selector = $("""<div class="debugger"></div>""")
    @button = $("""<button class="hideDebugger">Hide Debugger</button>""")
    $ =>
      $("body").append @container
      @container.append @selector, @button
    @button.click (evt)=>
      if @hidden = !@hidden
        console.log @button.text("Show Debugger")
      else
        console.log @button.text("Hide Debugger")
      @selector.toggle()


  debug: (item)->
    if typeof item is "object"
      try
        item = JSON.stringify(item, null, 2)
      catch e
        item = e
    @selector.prepend """<div class="inner">Debug: #{item}</div>"""


window.feDebug = new FeDebugger()

$ ->
  window.feDebug.debug("""You can call the integrated debugger with feDebug.debug("string" or obj)""")