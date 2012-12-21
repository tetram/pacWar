# Agent Planete

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

method PlaneteA addPlaneteToNoyau {} {
	set this(id) [$this(noyau) Add_new_planet $this(x) $this(y) $this(rayon) $this(densite)]
}

# Controlleur Planete
inherit Planete Control
method Planete constructor {parent rayon x y densite noyau canvasMap canvasMiniMap} {
   PlaneteA ${objName}_abst $objName $rayon $x $y $densite $noyau
   this inherited $parent ${objName}_abst
   ${objName}_abst addPlaneteToNoyau
   PlaneteMap ${objName}_presMap $objName $canvasMap $x $y $rayon
   PlaneteMiniMap ${objName}_presMiniMap $objName $canvasMiniMap $x $y $rayon
}

method Planete dispose {} {
   this inherited
}

# Agent PlaneteMiniMap

	# Controlleur PlaneteMiniMap
	inherit PlaneteMiniMap Control
	method PlaneteMiniMap constructor {parent canvas x y radius} {
	   PlaneteMiniMapP ${objName}_pres $objName $canvas $x $y $radius
	   this inherited $parent ${objName}_pres
	}

	method PlaneteMiniMap dispose {} {
	   this inherited
	}
	
	# Presentation PlaneteMiniMap
	inherit  PlaneteMiniMapP Presentation
	method  PlaneteMiniMapP constructor {control canvas x y radius} {
	   this inherited $control
	   
	   $canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill green -tags [list element $objName $control]
	}

# Agent PlaneteMap

	# Controlleur PlaneteMap
	inherit PlaneteMap Control
	method PlaneteMap constructor {parent canvas x y radius} {
	   PlaneteMapP ${objName}_pres $objName $canvas $x $y $radius
	   this inherited $parent ${objName}_pres
	}

	method PlaneteMap dispose {} {
	   this inherited
	}
	
	# Presentation PlaneteMap
	inherit PlaneteMapP Presentation
	method PlaneteMapP constructor {control canvas x y radius} {
	   this inherited $control
	   set rad [expr 2 * $radius]
	   $canvas create oval [expr $x - $rad] [expr $y - $rad] [expr $x + $rad] [expr $y + $rad] -fill green
	}
	
# Optionnel ? Pres_Info ???
