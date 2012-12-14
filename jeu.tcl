# Agent Jeu
source PAC.tcl
source univers.tcl
source info.tcl
source SWL_FC.tcl
source joueur.tcl

# Abstraction
inherit JeuA Abstraction
method JeuA constructor {control} {
   this inherited $control
   set this(listePlayers) {}
   set this(noyau) [SWL_FC S_$objName]
}

method JeuA newPlayer {name id} {
	lappend this(listePlayers) ${id}:${name}
	puts $this(listePlayers)
}

method JeuA dispose {} {
	puts ${objName}_dispose_called
	destroy $this(noyau)
	this inherited
}

# Controlleur
inherit Jeu Control
method Jeu constructor {parent} {
   JeuA ${objName}_abst $objName
   JeuP ${objName}_pres $objName 
   this inherited $parent ${objName}_abst ${objName}_pres
   
   Info ${objName}_info $objName [${objName}_pres attribute frameInfos] [${objName}_abst attribute listePlayers]
   
   #Joueur pour test !!
   Joueur ${objName}_toto $objName "toto" [${objName}_abst attribute noyau]
   Univers ${objName}_univ $objName [${objName}_abst attribute noyau] [${objName}_pres attribute frameMap] [${objName}_pres attribute frameMiniMap]
}

method Jeu dispose {} {
	puts ${objName}_dispose_called
   this inherited
}

method Jeu addPlayer {name} {
	Joueur ${objName}_joueur_${name} $objName $name [${objName}_abst attribute noyau]
	${objName}_abst newPlayer $name [${objName}_joueur_${name}_abst attribute id] 
	${objName}_info updateList [${objName}_joueur_${name}_abst attribute id]:${name}
}

# Presentation
inherit JeuP Presentation
method JeuP constructor {control} {
   this inherited $control
   
   set this(window) [toplevel .${objName} -width 400 -height 250]
   wm protocol $this(window) WM_DELETE_WINDOW "$this(control) dispose"
   
   set this(frameMap) [frame $this(window).frameMap]
   pack $this(frameMap) -side right -fill both -expand 1 
   
   set this(frameMiniMap) [frame $this(window).frameMiniMap]
   pack $this(frameMiniMap) -side top -fill both -expand 0
   
   set this(frameInfos) [frame $this(window).frameInfos]
   pack $this(frameInfos) -fill x -expand 1 
}

method JeuP dispose {} {
	puts ${objName}_dispose_called
	destroy $this(frameMap)
	destroy $this(frameMiniMap)
	destroy $this(frameInfos)
	destroy $this(window)
	this inherited
}
