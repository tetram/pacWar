# Agent Info

# Abstraction
inherit InfoA Abstraction
method InfoA constructor {control} {
   this inherited $control
}

# Controlleur
inherit Info Control
method Info constructor {parent frame listePlayer} {
   set this(parent) $parent
   InfoA ${objName}_abst $objName
   InfoP ${objName}_pres $objName $frame $listePlayer
   this inherited $parent ${objName}_abst ${objName}_pres
}

method Info addPlayer {name} {
	$this(parent) addPlayer $name
}

method Info updateList {joueur} {
	${objName}_pres updateList $joueur
}

# Presentation
inherit InfoP Presentation
method InfoP constructor {control frame listePlayer} {
	this inherited $control
	
	set ::${objName}_listePlayers {}
	
	set this(frame) $frame
	
	set this(playerList) [listbox $this(frame).playerList -listvariable ::${objName}_listePlayers -height 4]
	pack $this(playerList)
	
	set this(playerName) [entry $this(frame).playerName -justify left]
	pack $this(playerName) -expand 1
	
	set this(buttonAddPlayer) [button $this(frame).buttonAddPlayer -text "Ajouter un Joueur" -command "${objName} addPlayer"]
	pack $this(buttonAddPlayer) -expand 1
}

method InfoP updateList {joueur} {
	lappend ::${objName}_listePlayers $joueur
}

method InfoP addPlayer {} {
	$this(control) addPlayer [$this(playerName) get]
}

method InfoP dispose {} {
	puts ${objName}_dispose_called
	destroy ::${objName}_listePlayers
	this inherited
}