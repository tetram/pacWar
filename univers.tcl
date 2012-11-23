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
method Univers constructor {parent noyau canvas} {
   UniversA ${objName}_abst $objName $noyau
   this inherited $parent ${objName}_abst
   
   Planete test 10 10 10 10 $noyau $canvas
}

method Univers destructor {} {
   this inherited
}

# Agent Pres_Minimap

	# Controlleur Pres_MiniMap
	
	# Presentation Pres_MiniMap

# Agent Pres_Map

	# Controlleur Pres_Map
	
	# Presentation Pres_Map