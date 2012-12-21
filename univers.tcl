# Agent Univers
source vaisseau.tcl
source planete.tcl

# Abstraction Univers
inherit UniversA Abstraction
method UniversA constructor {control noyau} {
   this inherited $control
   set this(noyau) $noyau
}


# Controlleur Univers
inherit Univers Control
method Univers constructor {parent noyau frameMap frameMiniMap} {
   UniversA ${objName}_abst $objName $noyau
   this inherited $parent ${objName}_abst
   
   UnivMap ${objName}_presMap this $frameMap
   UnivMiniMap ${objName}_presMiniMap this $frameMiniMap
   
   Planete ${objName}_planetetest $objName 10 10 10 10 $noyau [${objName}_presMap getCanvas] [${objName}_presMiniMap getCanvas]
   Vaisseau ${objName}_vaisseautest $objName 50 30 5 "Player_1" Yellow $noyau [${objName}_presMap getCanvas] [${objName}_presMiniMap getCanvas]
}

method Univers dispose {} {
   this inherited
}

# Agent Pres_Map

	# Controlleur Pres_Map
	inherit UnivMap Control
	method UnivMap constructor {parent frame} {
	   UnivMapP ${objName}_pres $objName $frame
	   this inherited $parent ${objName}_pres
	}
	
	method UnivMap dispose {} {
	   this inherited
	}
	
	method UnivMap getCanvas {} {
		return [${objName}_pres getCanvas]
	}
	
	# Presentation Pres_Map
	inherit UnivMapP Presentation
	method UnivMapP constructor {control frame} {
		this inherited $control
	   
		set this(canvasMap) [canvas $frame.canvasMap -background Pink]
		pack $this(canvasMap) -expand 1 -fill both
	}
	
	method UnivMapP getCanvas {} {
		return $this(canvasMap)
	}

# Agent Pres_MiniMap

	# Controlleur Pres_MiniMap
	inherit UnivMiniMap Control
	method UnivMiniMap constructor {parent frame} {
	   UnivMiniMapP ${objName}_pres $objName $frame
	   this inherited $parent ${objName}_pres
	}
	
	method UnivMiniMap dispose {} {
	   this inherited
	}
	
	method UnivMiniMap getCanvas {} {
		return [${objName}_pres getCanvas]
	}
	
	# Presentation Pres_MiniMap
	inherit UnivMiniMapP Presentation
	method UnivMiniMapP constructor {control frame} {
		this inherited $control
	   
		set this(canvasMiniMap) [canvas $frame.canvasMiniMap -height 200 -width 200 -background Blue]
		pack $this(canvasMiniMap) -expand 1 -side top
	}
	
	method UnivMiniMapP getCanvas {} {
		return $this(canvasMiniMap)
	}
