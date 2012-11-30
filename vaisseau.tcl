# Agent Vaisseau

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
	inherit VaisseauMiniMap Control
	
	method VaisseauMiniMap constructor {parent canevas} {
	    VaisseauMiniMapP ${objName}_pres $objName 
	    this inherited $parent
	    set this(miniMap) $canevas
	}

    method VaisseauMiniMap change {x y radius color} {
        $this(presentation) change x y radius color
    }
	
	# Presentation Pres_MiniMap
	inherit VaisseauMiniMapP Presentation
	
	method VaisseauMiniMapP constructor {control} {
	    this inherited $control
	}
	
	method VaisseauMiniMapP change {x y radius color} {
	    $canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill $color
	}


# Agent Pres_Map

	# Controlleur Pres_Map
	inherit VaisseauMap Control
	
	method VaisseauMap constructor {parent canevas} {
	    VaisseauMapP ${objName}_pres $objName 
	    this inherited $parent
	    set this(miniMap) $canevas
	}

    method VaisseauMap change {x y radius color} {
        $this(presentation) change x y radius color
    }
	
	
	# Presentation Pres_Map
    inherit VaisseauMapP Presentation
	
	method VaisseauMapP constructor {control} {
	    this inherited $control
	}
	
	method VaisseauMapP change {x y radius color} {
	    $canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill $color
	}

# Agent Pres_Info

	# Controlleur Pres_Info
	
	# Presentation Pres_Info
