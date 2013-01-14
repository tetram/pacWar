# Agent Joueur

# Abstraction Joueur
inherit JoueurA Abstraction
method JoueurA constructor {control nom noyau} {
   this inherited $control 
   set this(nom) $nom
   set this(noyau) $noyau
}

method JoueurA addJoueurToNoyau {} {
	set this(id) [$this(noyau) Add_new_player $this(nom)]
	if {$this(id) == "Player_1"} {
		set this(color) Yellow
	} elseif {$this(id) == "Player_2"} {
		set this(color) Red
	} else {
		set this(color) Blue
	}
	puts $this(color)
}

# Controlleur Joueur
inherit Joueur Control
method Joueur constructor {parent nom noyau} {
   JoueurA ${objName}_abst $objName $nom $noyau
   this inherited $parent ${objName}_abst
   ${objName}_abst addJoueurToNoyau
}

method Joueur getId {} {
    return [$this(abstraction) attribute id]
}

method Joueur getColor {} {
	return [$this(abstraction) attribute color]
}

method Joueur dispose {} {
   this inherited
}

