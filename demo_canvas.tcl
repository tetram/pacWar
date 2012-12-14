package require Tk
canvas .c
pack .c -fill both -expand 1

.c create rect 0 0 10000 10000 -fill black -tags [list background]
.c bind background <Button-1>  "set dragged_object object; set last_x %x; set last_y %y"

set dragged_object ""; set last_x ""; set last_y ""
set col [list red blue green yellow]
for {set i 0} {$i < 10} {incr i} {
	 set id [.c create oval [expr 50*rand()] [expr 50*rand()] [expr 200*rand()] [expr 200*rand()] \
							-fill [lindex $col [expr $i % [llength $col]]] \
							-tags [list object] ]
	 .c bind $id <Button-1>  "set dragged_object $id; set last_x %x; set last_y %y"
	}

bind .c <B1-Motion> "update_drag %x %y"

proc update_drag {x y} {
	global dragged_object
	global last_x
	global last_y
	
	if {$dragged_object != ""} {
		 set dx [expr $x - $last_x]
		 set dy [expr $y - $last_y]
		 .c move $dragged_object $dx $dy
		 set last_x $x
		 set last_y $y
		}
}