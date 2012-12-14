# Agent Info
# TODO : creer un "joueur selectionné" pour pouvoir lui ajouter des vaisseaux... depuis l'onglet vaisseaux
#couleur associée à un joueur : en dur pour deux joueurs !! 

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
	set this(frameVaisseaux) [frame $this(frame).nb.frameVaisseaux]
	
	######## Contenu de la frame Players ########
	set this(playerList) [listbox $this(frame).nb.framePlayers.playerList -listvariable ::${objName}_listePlayers -height 2]
	pack $this(playerList)
	
	set this(playerName) [entry $this(frame).nb.framePlayers.playerName -justify left]
	pack $this(playerName) -expand 1
	
	set this(buttonAddPlayer) [button $this(frame).nb.framePlayers.buttonAddPlayer -text "Ajouter un Joueur" -command "${objName} addPlayer"]
	pack $this(buttonAddPlayer) -expand 1
	#############################################
	
	
	######## Contenu de la frame Vaisseaux ########
	
	set this(frameVaisseauX) [frame $this(frame).nb.frameVaisseaux.frameVaisseauX]
	pack $this(frameVaisseauX) -expand 1
	
	set this(frameVaisseauY) [frame $this(frame).nb.frameVaisseaux.frameVaisseauY]
	pack $this(frameVaisseauY) -expand 1
	
	set this(frameVaisseauRadius) [frame $this(frame).nb.frameVaisseaux.frameVaisseauRadius]
	pack $this(frameVaisseauRadius) -expand 1
	
	set this(buttonAddVaisseau) [button $this(frame).nb.frameVaisseaux.buttonAddVaisseau -text "Ajouter un Vaisseau" -command "${objName} addShip"]
	pack $this(buttonAddVaisseau) -expand 1 -side bottom
	
	set this(entryX) [entry $this(frame).nb.frameVaisseaux.frameVaisseauX.entryX -justify left]
   pack $this(entryX) -expand 1 -side right
	
	set this(labelX) [label $this(frame).nb.frameVaisseaux.frameVaisseauX.labelX -text "X : "  -justify right]
	pack $this(labelX) -expand 1
	
	set this(entryY) [entry $this(frame).nb.frameVaisseaux.frameVaisseauY.entryY -justify left]
   pack $this(entryY) -expand 1  -side right
   
	set this(labelY) [label $this(frame).nb.frameVaisseaux.frameVaisseauY.labelY -text "Y : "  -justify right]
	pack $this(labelY) -expand 1
	
	set this(entryRadius) [entry $this(frame).nb.frameVaisseaux.frameVaisseauRadius.entryRadius -justify left]
   pack $this(entryRadius) -expand 1  -side right
   
	set this(labelRadius) [label $this(frame).nb.frameVaisseaux.frameVaisseauRadius.labelRadius -text "Radius : "  -justify right]
	pack $this(labelRadius) -expand 1
	#############################################
	
	$this(frame).nb add $this(framePlayers) -text "Joueurs"
	$this(frame).nb add $this(frameVaisseaux) -text "Vaisseaux"
	$this(frame).nb select $this(frame).nb.framePlayers
}

method InfoP updatePlayersList {joueur} {
	lappend ::${objName}_listePlayers $joueur
}

method InfoP addPlayer {} {
	$this(control) addPlayer [$this(playerName) get]
}

method InfoP addShip {} {
	puts not_supported_yet
}

method InfoP dispose {} {
	puts ${objName}_dispose_called
	destroy ::${objName}_listePlayers
	this inherited
}