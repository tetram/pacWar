# Agent Planete
source PAC.tcl

# Abstraction Planete
inherit PlaneteA Abstraction
method PlaneteA constructor {control rayon x y densite noyau} {
   this inherited $control
   set this(rayon) $rayon
   set this(x) $x
   set this(y) $y
   set this(densite) $densite
   set this(noyau) $noyau
}

#TODO ajouter planete au noyau

# Controlleur Planete
inherit Planete Control
method Planete constructor {parent rayon x y densite noyau canvasMap canvasMiniMap} {
   PlaneteA ${objName}_abst $objName $rayon $x $y $densite $noyau
   this inherited $parent ${objName}_abst
   
   PlaneteMap ${objName}_presMap $objName $canvasMap $x $y $rayon
   PlaneteMiniMap ${objName}_presMiniMap $objName $canvasMiniMap $x $y $rayon
}

method Planete destructor {} {
   this inherited
}


# Agent PlaneteMiniMap

	# Controlleur PlaneteMiniMap
	inherit PlaneteMiniMap Control
	method PlaneteMiniMap constructor {parent canvas x y radius} {
	   PlaneteMiniMapP ${objName}_pres $objName $canvas $x $y $radius
	   this inherited $parent ${objName}_abst
	}

	method PlaneteMiniMap destructor {} {
	   this inherited
	}
	
	# Presentation PlaneteMiniMap
	inherit  PlaneteMiniMapP Presentation
	method  PlaneteMiniMapP constructor {control canvas x y radius} {
	   this inherited $control
	   
	   $canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill green
	}

# Agent PlaneteMap

	# Controlleur PlaneteMap
	inherit PlaneteMap Control
	method PlaneteMap constructor {parent canvas x y radius} {
	   PlaneteMapP ${objName}_pres $objName $canvas $x $y $radius
	   this inherited $parent ${objName}_abst
	}

	method PlaneteMap destructor {} {
	   this inherited
	}
	
	# Presentation PlaneteMap
	inherit PlaneteMapP Presentation
	method PlaneteMapP constructor {control canvas x y radius} {
	   this inherited $control
	   
	   $canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill green
	}
	
# Optionnel ? Pres_Info ???
