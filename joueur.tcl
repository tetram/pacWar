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
	puts $this(id)
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

method Joueur dispose {} {
   this inherited
}
