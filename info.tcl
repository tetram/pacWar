# Agent Info

# Abstraction
inherit InfoA Abstraction
method InfoA constructor {control} {
   this inherited $control
}

# Controlleur
inherit Info Control
method Info constructor {parent frame} {
   InfoA ${objName}_abst $objName
   InfoP ${objName}_pres $objName $frame
   this inherited $parent ${objName}_abst ${objName}_pres
}

# Presentation
inherit InfoP Presentation
method InfoP constructor {control frame} {
	this inherited $control
	
	set this(frame) $frame
	
	set this(buttonOk) [button $this(frame).buttonOk -text "ok"]
	pack $this(buttonOk) -expand 1 -fill both
}