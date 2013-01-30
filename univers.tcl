# Agent Univers
source vaisseau.tcl
source planete.tcl

set identifiantNewObject 0

# Abstraction Univers
inherit UniversA Abstraction
method UniversA constructor {control noyau} {
   this inherited $control
   set this(noyau) $noyau
}

method UniversA getNoyau {} {
    return $this(noyau)
}


# Controlleur Univers
inherit Univers Control
method Univers constructor {parent noyau frameMap frameMiniMap} {
   UniversA ${objName}_abst $objName $noyau
   this inherited $parent ${objName}_abst
   set this(uMap) [UnivMap ${objName}_presMap this $frameMap]
   UnivMiniMap ${objName}_presMiniMap this $frameMiniMap

   $noyau Subscribe_after_Start_fire ${objName}_start "${objName}_presMap createBullet \$this(L_bullets)"
   $noyau Subscribe_after_Compute_a_simulation_step ${objName}_step "${objName}_presMap updateBullet \$this(L_bullets)"
   $noyau Subscribe_after_Destroy_ship ${objName}_rm_ship "${objName}_presMap destroyShip \$id; ${objName}_presMiniMap destroyShip \$id;"
}

method Univers addPlanete {x y radius densite} {
    Planete [$objName newName] $objName $radius $x $y $densite [$this(abstraction) getNoyau] [${objName}_presMap getCanvas] [${objName}_presMiniMap getCanvas]
}

method Univers addShip {player} {
    Vaisseau [$objName newName] $objName 50 50 5 [$player getId] [$player getColor] [$this(abstraction) getNoyau] [${objName}_presMap getCanvas] [${objName}_presMiniMap getCanvas]
    
}

method Univers updateSelectedShip {joueur vaisseau v a} {
	$this(parent) updateSelectedShip $joueur $vaisseau $v $a
}

method Univers editShip {selectedPlayer selectedShip v a} {
	
}

method Univers dispose {} {
   this inherited
}

method Univers newName {} {
    global identifiantNewObject
    incr identifiantNewObject
    return ${objName}_$identifiantNewObject
}

# Agent Pres_Map

	# Controlleur Pres_Map
	inherit UnivMap Control
	method UnivMap constructor {parent frame} {
	   UnivMapP ${objName}_pres $objName $frame
	   this inherited $parent ${objName}_pres
	}
	
	method UnivMap dispose {} {
	   this inherited
	}
	
	method UnivMap getCanvas {} {
		return [${objName}_pres getCanvas]
	}
	
	method UnivMap createBullet {L_bullets} {
	  ${objName}_pres createBullet $L_bullets
	}
	
	method UnivMap updateBullet {L_bullets} {
	  ${objName}_pres updateBullet $L_bullets
	}
	
	method UnivMap destroyShip {id} {
	  ${objName}_pres destroyShip $id
	}
	
	# Presentation Pres_Map
	inherit UnivMapP Presentation
	method UnivMapP constructor {control frame} {
		this inherited $control
	  
		set this(canvasMap) [canvas $frame.canvasMap -background Pink]
		pack $this(canvasMap) -expand 1 -fill both
		upvar .map $this(canvasMap)
	}
	
	method UnivMapP getCanvas {} {
		return $this(canvasMap)
	}
	method UnivMapP createBullet {L_bullets} {
	  $this(canvasMap) delete Bullet
    set radius 2
    foreach {id x y vx vy} $L_bullets {
        $this(canvasMap) create oval [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius] -fill black -tags [list Bullet $id]
    }
	}
	
	method UnivMapP updateBullet {L_bullets} {
    set radius 2
    foreach {id x y vx vy} $L_bullets {
      $this(canvasMap) coords $id [expr $x - $radius] [expr $y - $radius] [expr $x + $radius] [expr $y + $radius]
    }
	}
	
	method UnivMapP destroyShip {id} {
	  $this(canvasMap) delete $id
	}

# Agent Pres_MiniMap

	# Controlleur Pres_MiniMap
	inherit UnivMiniMap Control
	method UnivMiniMap constructor {parent frame} {
	   UnivMiniMapP ${objName}_pres $objName $frame
	   this inherited $parent ${objName}_pres
	}
	
	method UnivMiniMap dispose {} {
	   this inherited
	}
	
	method UnivMiniMap getCanvas {} {
		return [${objName}_pres getCanvas]
	}
	
	method UnivMiniMap destroyShip {id} {
	  ${objName}_pres destroyShip $id
	}
	
	# Presentation Pres_MiniMap
	inherit UnivMiniMapP Presentation
	method UnivMiniMapP constructor {control frame} {
		this inherited $control
	   
		set this(canvasMiniMap) [canvas $frame.canvasMiniMap -height 200 -width 200 -background Blue]
		pack $this(canvasMiniMap) -expand 1 -side top
	}
	
	method UnivMiniMapP getCanvas {} {
		return $this(canvasMiniMap)
	}
	
	method UnivMiniMapP destroyShip {id} {
	  $this(canvasMiniMap) delete $id
	}
