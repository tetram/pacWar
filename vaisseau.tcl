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
method Vaisseau constructor {parent x y radius joueur color noyau canvasMap canvasMiniMap} {
   VaisseauA ${objName}_abst $objName $x $y $radius $joueur $noyau
   this inherited $parent ${objName}_abst
   
   ${objName}_abst addVaisseauToNoyau
   VaisseauMap ${objName}_presMap $objName $x $y $radius $color $canvasMap
   VaisseauMiniMap ${objName}_presMiniMap $objName $x $y $radius $color $canvasMiniMap
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
	    this inherited $parent ${objName}_pres
	    set this(miniMap) $canvas
	}

	
	# Presentation Pres_MiniMap
    inherit VaisseauMiniMapP Presentation
	method VaisseauMiniMapP constructor {control x y radius color canvas} {
	    this inherited $control
		$canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill $color -tags [list element $objName $control]
	}

	method VaisseauMiniMapP move {canvas control x y} {
	    $canvas move $control $x $y
	}

# Agent Pres_Map

	# Controlleur Pres_Map
	inherit VaisseauMap Control
	method VaisseauMap constructor {parent x y radius color canvas} {
	    VaisseauMapP ${objName}_pres $objName $x $y $radius $color $canvas
	    this inherited $parent ${objName}_pres
	    set this(Map) $canvas
	}

	# Presentation Pres_Map
    inherit VaisseauMapP Presentation
	method VaisseauMapP constructor {control x y radius color canvas} {
	    this inherited $control
		$canvas create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill $color -tags [list element $objName $control]
	}

	method VaisseauMapP move {canvas control x y} {
	    $canvas move $control $x $y
	}

# Agent Pres_Info

	# Controlleur Pres_Info
	
	# Presentation Pres_Info
