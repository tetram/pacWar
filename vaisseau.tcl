# Agent Vaisseau
source PAC.tcl

# Abstraction Vaisseau
inherit VaisseauA Abstraction
method VaisseauA constructor {control x y radius joueur noyau} {
   this inherited $control
   set this(x) $x
   set this(y) $y
   set this(radius) $radius
   set this(joueur) $joueur
   set this(noyau) $noyau
}

method VaisseauA addVaisseauToNoyau {} {
	set this(id) [$this(noyau) Add_new_ship $this(joueur) $this(x) $this(y) $this(radius)]
}

# Controlleur Vaisseau
inherit Vaisseau Control
method Vaisseau constructor {parent x y radius joueur noyau} {
   VaisseauA ${objName}_abst $objName $x $y $radius $joueur $noyau
   this inherited $parent ${objName}_abst
   
   ${objName}_abst addVaisseauToNoyau
}

method Vaisseau destructor {} {
   this inherited
   #TODO : supprimer du noyau avant ?
}

# Agent Pres_MiniMap

	# Controlleur Pres_MiniMap
	
	# Presentation Pres_MiniMap


# Agent Pres_Map

	# Controlleur Pres_Map
	
	# Presentation Pres_Map


# Agent Pres_Info

	# Controlleur Pres_Info
	
	# Presentation Pres_Info
