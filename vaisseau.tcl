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

method VaisseauA editPosition {x y} {
    #TODO faire l'appel au noyau
    set this(x) $x
    set this(y) $y
    this positionChange
}

method VaisseauA positionChange {} {
   $this(control) positionChange $this(x) $this(y)
}

# Controlleur Vaisseau
inherit Vaisseau Control
method Vaisseau constructor {parent x y radius joueur color noyau canvasMap canvasMiniMap} {
    VaisseauA ${objName}_abst $objName $x $y $radius $joueur $noyau
   this inherited $parent ${objName}_abst
   
   ${objName}_abst addVaisseauToNoyau
   
   VaisseauMap ${objName}_presMap $objName $x $y $radius $color $canvasMap
   VaisseauMiniMap ${objName}_presMiniMap $objName $x $y $radius $color $canvasMiniMap
   ${objName} editPosition $x $y
}

method Vaisseau editPosition {x y} {
    $this(abstraction) editPosition $x $y
}

method Vaisseau positionChange {x y} {
   foreach child $this(children) {
        $child positionChange $x $y
   }
}

method Vaisseau dispose {} {
   this inherited
   #TODO : supprimer du noyau avant ?
}

# Agent Pres_MiniMap
	# Controlleur Pres_MiniMap
	inherit VaisseauMiniMap Control
	
	method VaisseauMiniMap constructor {parent x y radius color canvas} {
	    VaisseauMiniMapP ${objName}_pres $objName $x $y $radius $color $canvas
	    this inherited $parent "" ${objName}_pres
	}
	
	method VaisseauMiniMap positionChange {x y} {
	    $this(presentation) positionChange $x $y
    }
    
    method VaisseauMiniMap dispose {} {
	   this inherited
	}
	
	# Presentation Pres_MiniMap
    inherit VaisseauMiniMapP Presentation
	method VaisseauMiniMapP constructor {control x y radius color canvas} {
	    this inherited $control
		set this(oval) [$canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill $color -tags [list element $objName $control]]
		 set this(last_x) $x
		 set this(last_y) $y
		 set this(canvas) $canvas 
	}

	method VaisseauMiniMapP positionChange {x y} {
	        set dx [expr $x - $this(last_x)]
	        set dy [expr $y - $this(last_y)]
	        $this(canvas) move $this(oval) $dx $dy
	        set this(last_x) $x
		    set this(last_y) $y
	}

# Agent Pres_Map

	# Controlleur Pres_Map
	inherit VaisseauMap Control
	method VaisseauMap constructor {parent x y radius color canvas} {
	    VaisseauMapP ${objName}_pres $objName $x $y $radius $color $canvas
	    this inherited $parent "" ${objName}_pres
	    $canvas bind v1 <B1-Motion> "${objName}_pres editPosition %x %y"
	}
	
	method VaisseauMap editPosition {id x y} {
	    $this(parent) editPosition $x $y
	}
	
	method VaisseauMap positionChange {x y} {
	    $this(presentation) positionChange $x $y
	}
	
	method VaisseauMap dispose {} {
	   this inherited
	}
	

	# Presentation Pres_Map
    inherit VaisseauMapP Presentation
	method VaisseauMapP constructor {control x y radius color canvas} {
	    this inherited $control
	    set this(canvas) $canvas
	    set rad [expr 2 * $radius]
		#set this(oval) [$canvas create oval [expr $x - $rad] [expr $y - $rad] [expr $x + $rad] [expr $y + $rad] -fill $color -tags [list element $objName $control]] 
		set this(oval) [$canvas create oval [expr $x - $rad] [expr $y - $rad] [expr $x + $rad] [expr $y + $rad] -fill $color -tags v1] 
		set this(last_x) $x
		set this(last_y) $y
	}
	
	method VaisseauMapP editPosition {x y} {
	    $this(control) editPosition $this(oval) [expr $x / 2] [expr $y / 2] 
	}
	
	method VaisseauMapP positionChange {x y} {
	    this move [expr $x * 2]  [expr $y * 2]
	}

	method VaisseauMapP move {x y} {
	    set dx [expr $x - $this(last_x)]
	    set dy [expr $y - $this(last_y)]
	    $this(canvas) move $this(oval) $dx $dy
	    set this(last_x) $x
		set this(last_y) $y
	}

# Agent Pres_Info

	# Controlleur Pres_Info
	
	# Presentation Pres_Info
