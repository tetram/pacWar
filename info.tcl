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

method Info updateSelectedShip {joueur vaisseau v a} {
	${objName}_pres updateSelectedShip $joueur $vaisseau $v $a
}

method Info editShip {selectedPlayer selectedShip v a} {
	$this(parent) editShip $selectedPlayer $selectedShip  $v $a
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
	set this(frameVaisseau) [frame $this(frame).nb.frameVaisseau]
	
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
	
	######## Contenu de la frame Vaisseau ########
	
	set this(frameVaisseuVel) [frame $this(frame).nb.frameVaisseau.frameVaisseuVel]
	pack $this(frameVaisseuVel) -expand 1
	
	set this(frameVaisseauAng) [frame $this(frame).nb.frameVaisseau.frameVaisseauAng]
	pack $this(frameVaisseauAng) -expand 1
	
	set this(buttonEditShip) [button $this(frame).nb.frameVaisseau.buttonEditShip -text "Editer" -command "${objName} editShip"]
	pack $this(buttonEditShip) -expand 1 -side bottom
	
	set this(entryVel) [entry $this(frame).nb.frameVaisseau.frameVaisseuVel.entryX -justify left]
	 
   pack $this(entryVel) -expand 1 -side right
	
	set this(labelVel) [label $this(frame).nb.frameVaisseau.frameVaisseuVel.labelVel -text "X : "  -justify right]
	pack $this(labelVel) -expand 1
	
	set this(entryAng) [entry $this(frame).nb.frameVaisseau.frameVaisseauAng.entryAng -justify left]
   pack $this(entryAng) -expand 1  -side right
   
	set this(labelAng) [label $this(frame).nb.frameVaisseau.frameVaisseauAng.labelAng -text "Y : "  -justify right]
	pack $this(labelAng) -expand 1
	
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
	$this(frame).nb add $this(frameVaisseau) -text "Vaisseau"
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

method InfoP editShip {} {
	if {![info exists this(selectedShip)]} {
		error "There is no ship selected"
	} else {
		$this(control) editShip $this(selectedPlayer) $this(selectedShip) [$this(entryVel) get] [$this(entryAng) get]
	}
	puts "edit pressed"
}

method InfoP updateSelectedShip {idPlayer idShip v a} {
	$this(entryVel) delete 0 end
	$this(entryAng) delete 0 end
	$this(entryVel) insert 0 $v
	$this(entryAng) insert 0 $a
	set this(selectedPlayer) $idPlayer
	set this(selectedShip) $idShip
}

method InfoP addShip {} {
	set listeSelected [ lindex [$this(playerList) curselection] 0]
	if {[llength $listeSelected] == 1} {
		$this(control) addShip $listeSelected
	} else {
		tk_messageBox -message "Veuillez selectionner un joueur" -type ok -icon question
	}
}

method InfoP dispose {} {
	puts ${objName}_dispose_called
	destroy ::${objName}_listePlayers
	this inherited
}
