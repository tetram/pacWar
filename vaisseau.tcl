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
   set this(v) 0
   set this(a) 0
}

method VaisseauA addVaisseauToNoyau {} {
	set this(id) [$this(noyau) Add_new_ship $this(joueur) $this(x) $this(y) $this(radius)]
	puts ${objName}
}

method VaisseauA editPosition {x y} {
    set this(x) $x
    set this(y) $y
    $this(noyau) Update_ship $this(joueur) $this(id) [dict create x $x y $y]
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
   
   VaisseauMap ${objName}_presMap $objName [${objName}_abst attribute id] $x $y $radius $color $canvasMap
   VaisseauMiniMap ${objName}_presMiniMap $objName [${objName}_abst attribute id] $x $y $radius $color $canvasMiniMap
   
   ${objName} editPosition $x $y
}

method Vaisseau editPosition {x y} {
    $this(abstraction) editPosition $x $y
}

method Vaisseau updateSelectedShip {} {
	$this(parent) updateSelectedShip [${objName}_abst attribute joueur] [${objName}_abst attribute id] [${objName}_abst attribute v] [${objName}_abst attribute a]
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
	
	method VaisseauMiniMap constructor {parent id x y radius color canvas} {
	    VaisseauMiniMapP ${objName}_pres $objName $id $x $y $radius $color $canvas
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
	method VaisseauMiniMapP constructor {control id x y radius color canvas} {
	    this inherited $control
	    set radius [expr $radius / 2]
	    set x [expr $x / 2]  
	    set y [expr $y / 2]
		set this(oval) [$canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill $color -tags $id]
		 set this(last_x) $x
		 set this(last_y) $y
		 set this(canvas) $canvas 
	}

	method VaisseauMiniMapP positionChange {x y} {
	        set x [expr $x / 2]  
	        set y [expr $y / 2]
	        set dx [expr $x - $this(last_x)]
	        set dy [expr $y - $this(last_y)]
	        $this(canvas) move $this(oval) $dx $dy
	        set this(last_x) $x
		    set this(last_y) $y
	}

# Agent Pres_Map

	# Controlleur Pres_Map
	inherit VaisseauMap Control
	method VaisseauMap constructor {parent id x y radius color canvas} {
	    VaisseauMapP ${objName}_pres $objName $id $x $y $radius $color $canvas
	    this inherited $parent "" ${objName}_pres
	    $canvas bind $id <B1-Motion> "${objName}_pres editPosition %x %y"
		$canvas bind $id <1> "${objName} updateSelectedShip"
	}
	
	method VaisseauMap editPosition {id x y} {
	    $this(parent) editPosition $x $y
	}
	
	method VaisseauMap updateSelectedShip {} {
		$this(parent) updateSelectedShip
	}
	
	method VaisseauMap positionChange {x y} {
	    $this(presentation) positionChange $x $y
	}
	
	method VaisseauMap dispose {} {
	   this inherited
	}
	

	# Presentation Pres_Map
    inherit VaisseauMapP Presentation
	method VaisseauMapP constructor {control id x y radius color canvas} {
	    this inherited $control
	    set this(canvas) $canvas
		#set this(oval) [$canvas create oval [expr $x - $rad] [expr $y - $rad] [expr $x + $rad] [expr $y + $rad] -fill $color -tags [list element $objName $control]] 
		set this(oval) [$canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill $color -tags $id] 
		set this(last_x) $x
		set this(last_y) $y
	}
	
	method VaisseauMapP editPosition {x y} {
	    $this(control) editPosition $this(oval) $x $y
	}
	
	method VaisseauMapP positionChange {x y} {
	    this move $x $y
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
