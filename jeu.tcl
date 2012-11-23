# Agent Jeu
source univers.tcl
source SWL_FC.tcl

# Abstraction
inherit JeuA Abstraction
method JeuA constructor {control} {
   this inherited $control
   set this(noyau) [SWL_FC S_$objName]
}


# Controlleur
inherit Jeu Control
method Jeu constructor {parent} {
   JeuA ${objName}_abst $objName
   JeuP ${objName}_pres $objName
   this inherited $parent ${objName}_abst ${objName}_pres
   
   Univers ${objName}_univ $objName ${objName}_abst(noyau) [${objName}_pres attribute canvasMap]
}

method Jeu destructor {} {
   this inherited
}

# Presentation
inherit JeuP Presentation
method JeuP constructor {control} {
   this inherited $control
   
   set this(window) [toplevel .${objName}]
   wm protocol $this(window) WM_DELETE_WINDOW "$this(control) dispose"
   
   set this(canvasMap) [canvas $this(window).canvasMap]
   pack $this(canvasMap) -expand 1 -side right
   
   set this(canvasMiniMap) [canvas $this(window).canvasMiniMap]
   pack $this(canvasMiniMap) -expand 1 -side left
   
   set this(frameInfos) [frame $this(window).frameInfos]
   pack $this(frameInfos) -expand 1 -side left
}


method JeuP destructor {} {
	destroy $this(frameInfos)
	destroy $this(canvasMiniMap)
	destroy $this(canvasMap)
	destroy $this(window)
}
