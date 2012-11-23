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
method Planete constructor {parent rayon x y densite noyau canvas} {
   PlaneteA ${objName}_abst $objName $rayon $x $y $densite $noyau
   this inherited $parent ${objName}_abst
   
   Pres_Map ${objName}_presMap $objName $canvas $x $y $rayon
}

method Planete destructor {} {
   this inherited
}


# Agent Pres_MiniMap

	# Controlleur Pres_MiniMap
	
	# Presentation Pres_MiniMap

# Agent Pres_Map

	# Controlleur Pres_Map
	inherit Pres_Map Control
	method Pres_Map constructor {parent canvas x y radius} {
	   Pres_MapP ${objName}_pres $objName $canvas $x $y $radius
	   this inherited $parent ${objName}_abst
	}

	method Pres_Map destructor {} {
	   this inherited
	}
	
	# Presentation Pres_Map
	inherit Pres_MapP Presentation
	method Pres_MapP constructor {control canvas x y radius} {
	   this inherited $control
	   
	   $canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill green
	}
	
# Optionnel ? Pres_Info ???