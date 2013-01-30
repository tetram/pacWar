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

method PlaneteA editPosition {x y} {
    set this(x) $x
    set this(y) $y
    $this(noyau) Update_planet $this(id) [dict create x $x y $y radius $this(rayon) density $this(densite)]
    this positionChange
}

method PlaneteA positionChange {} {
   $this(control) positionChange $this(x) $this(y)
}

# Controlleur Planete
inherit Planete Control
method Planete constructor {parent rayon x y densite noyau canvasMap canvasMiniMap} {
   PlaneteA ${objName}_abst $objName $rayon $x $y $densite $noyau
   this inherited $parent ${objName}_abst
   ${objName}_abst addPlaneteToNoyau
   PlaneteMap ${objName}_presMap $objName $objName $canvasMap $x $y $rayon
   PlaneteMiniMap ${objName}_presMiniMap $objName $canvasMiniMap $x $y $rayon
   ${objName} editPosition $x $y
}

method Planete editPosition {x y} {
    $this(abstraction) editPosition $x $y
}

method Planete positionChange {x y} {
   foreach child $this(children) {
        $child positionChange $x $y
   }
}

method Planete dispose {} {
   this inherited
}

# Agent PlaneteMiniMap

	# Controlleur PlaneteMiniMap
	inherit PlaneteMiniMap Control
	method PlaneteMiniMap constructor {parent canvas x y radius} {
	   PlaneteMiniMapP ${objName}_pres $objName $canvas $x $y $radius
	   this inherited $parent "" ${objName}_pres
	}
	
	method PlaneteMiniMap positionChange {x y} {
	    $this(presentation) positionChange $x $y
    }

	method PlaneteMiniMap dispose {} {
	   this inherited
	}
	
	# Presentation PlaneteMiniMap
	inherit  PlaneteMiniMapP Presentation
	method  PlaneteMiniMapP constructor {control canvas x y radius} {
	   this inherited $control
	   
	   set this(oval) [$canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill green -tags [list element $objName $control]]
	   
	   set this(last_x) $x
        set this(last_y) $y
        set this(canvas) $canvas 
	}
	
	method PlaneteMiniMapP positionChange {x y} {
	        set dx [expr $x - $this(last_x)]
	        set dy [expr $y - $this(last_y)]
	        $this(canvas) move $this(oval) $dx $dy
	        set this(last_x) $x
		    set this(last_y) $y
	}

# Agent PlaneteMap

	# Controlleur PlaneteMap
	inherit PlaneteMap Control
	method PlaneteMap constructor {parent id canvas x y radius} {
	   PlaneteMapP ${objName}_pres $objName $id $canvas $x $y $radius
	   this inherited $parent "" ${objName}_pres
	   $canvas bind $id <B1-Motion> "${objName}_pres editPosition %x %y"
	}
	
	method PlaneteMap editPosition {id x y} {
	    $this(parent) editPosition $x $y
	}
	
	method PlaneteMap positionChange {x y} {
	    $this(presentation) positionChange $x $y
	}

	method PlaneteMap dispose {} {
	   this inherited
	}
	
	# Presentation PlaneteMap
	inherit PlaneteMapP Presentation
	method PlaneteMapP constructor {control id canvas x y radius} {
	   this inherited $control
	   set this(canvas) $canvas
	   set rad [expr 2 * $radius]
	   set this(oval) [$canvas create oval [expr $x - $rad] [expr $y - $rad] [expr $x + $rad] [expr $y + $rad] -fill green -tags $id]
	   set this(last_x) $x
		set this(last_y) $y
	}
	
	method PlaneteMapP editPosition {x y} {
	    $this(control) editPosition $this(oval) $x $y
	}
	
	method PlaneteMapP positionChange {x y} {
	    this move $x $y
	}

	method PlaneteMapP move {x y} {
	    set dx [expr $x - $this(last_x)]
	    set dy [expr $y - $this(last_y)]
	    $this(canvas) move $this(oval) $dx $dy
	    set this(last_x) $x
		set this(last_y) $y
	}
	
# Optionnel ? Pres_Info ???
