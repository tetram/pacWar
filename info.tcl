# Agent Info
# TODO couleur associée à un joueur : en dur pour deux joueurs !! 

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
method Info addShip {index} {
	$this(parent) addShip $index
}
method Info addPlanete {x y radius densite} {
	$this(parent) addPlanete $x $y $radius $densite
}
method Info updatePlayersList {joueur} {
	${objName}_pres updatePlayersList $joueur
}

# Presentation
inherit InfoP Presentation
method InfoP constructor {control frame listePlayer} {
	this inherited $control
	
	set ::${objName}_listePlayers {}
	
	set this(frame) $frame
	
	set this(notebook) [ttk::notebook $this(frame).nb]
	pack $this(notebook) -expand 1
	
	set this(framePlayers) [frame $this(frame).nb.framePlayers]
	set this(framePlanetes) [frame $this(frame).nb.framePlanetes]
	
	######## Contenu de la frame Players ########
	set this(playerList) [listbox $this(frame).nb.framePlayers.playerList -listvariable ::${objName}_listePlayers -height 2]
	pack $this(playerList)
	
	set this(playerName) [entry $this(frame).nb.framePlayers.playerName -justify left]
	pack $this(playerName) -expand 1
	
	set this(buttonAddPlayer) [button $this(frame).nb.framePlayers.buttonAddPlayer -text "Ajouter un Joueur" -command "${objName} addPlayer"]
	pack $this(buttonAddPlayer) -expand 1
	
	set this(buttonAddVaisseau) [button $this(frame).nb.framePlayers.buttonAddVaisseau -text "Ajouter un Vaisseau" -command "${objName} addShip"]
	pack $this(buttonAddVaisseau) -expand 1
	#############################################
	
	
	######## Contenu de la frame Planetes ########
	
	set this(framePlaneteX) [frame $this(frame).nb.framePlanetes.framePlaneteX]
	pack $this(framePlaneteX) -expand 1
	
	set this(framePlaneteY) [frame $this(frame).nb.framePlanetes.framePlaneteY]
	pack $this(framePlaneteY) -expand 1
	
	set this(framePlaneteRadius) [frame $this(frame).nb.framePlanetes.framePlaneteRadius]
	pack $this(framePlaneteRadius) -expand 1
	
	set this(framePlaneteDensite) [frame $this(frame).nb.framePlanetes.framePlaneteDensite]
	pack $this(framePlaneteDensite) -expand 1
	
	set this(buttonAddPlanete) [button $this(frame).nb.framePlanetes.buttonAddPlanete -text "Ajouter un Planete" -command "${objName} addPlanete"]
	pack $this(buttonAddPlanete) -expand 1 -side bottom
	
	set this(entryX) [entry $this(frame).nb.framePlanetes.framePlaneteX.entryX -justify left]
	 
   pack $this(entryX) -expand 1 -side right
	
	set this(labelX) [label $this(frame).nb.framePlanetes.framePlaneteX.labelX -text "X : "  -justify right]
	pack $this(labelX) -expand 1
	
	set this(entryY) [entry $this(frame).nb.framePlanetes.framePlaneteY.entryY -justify left]
   pack $this(entryY) -expand 1  -side right
   
	set this(labelY) [label $this(frame).nb.framePlanetes.framePlaneteY.labelY -text "Y : "  -justify right]
	pack $this(labelY) -expand 1
	
	set this(entryRadius) [entry $this(frame).nb.framePlanetes.framePlaneteRadius.entryRadius -justify left]
   pack $this(entryRadius) -expand 1  -side right
   
	set this(labelRadius) [label $this(frame).nb.framePlanetes.framePlaneteRadius.labelRadius -text "Radius : "  -justify right]
	pack $this(labelRadius) -expand 1
	
	set this(entryDensite) [entry $this(frame).nb.framePlanetes.framePlaneteDensite.entryDensite -justify left]
   pack $this(entryDensite) -expand 1  -side right
   
	set this(labelDensite) [label $this(frame).nb.framePlanetes.framePlaneteDensite.labelDensite -text "Densité : "  -justify right]
	pack $this(labelDensite) -expand 1
	
	#default values
	$this(entryX) insert 0 10
	$this(entryY) insert 0 10
	$this(entryRadius) insert 0 10
	$this(entryDensite) insert 0 10
	
	#############################################
	
	$this(frame).nb add $this(framePlayers) -text "Joueurs"
	$this(frame).nb add $this(framePlanetes) -text "Planetes"
	$this(frame).nb select $this(frame).nb.framePlayers
}

method InfoP updatePlayersList {joueur} {
	lappend ::${objName}_listePlayers $joueur
}

method InfoP addPlayer {} {
	$this(control) addPlayer [$this(playerName) get]
}

method InfoP addPlanete {} {
	$this(control) addPlanete [$this(entryX) get] [$this(entryY) get] [$this(entryRadius) get] [$this(entryDensite) get]
}

method InfoP addShip {} {
	$this(control) addShip [ lindex [$this(playerList) curselection] 0]
}

method InfoP dispose {} {
	puts ${objName}_dispose_called
	destroy ::${objName}_listePlayers
	this inherited
}
