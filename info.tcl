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
	
	set this(playerName) [entry $this(window).playerName -justify right]
	pack $this(playerName) -expand 1
	
	set this(buttonAddPlayer) [button $this(frame).buttonAddPlayer -text "Ajouter un Joueur"]
	pack $this(buttonOk) -expand 1
}
