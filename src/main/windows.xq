for tumbling window $w in (2, 4, 6, 8, 10, 12, 14)
start at $s when fn:true()
only end at $e when $e - $s eq 2
return <window>{ $w }</window>,



for sliding window $w in (2, 4, 6, 8, 10, 12, 14)
start at $s when fn:true()
only end at $e when $e - $s eq 2
return <window>{ $w }</window>,

for tumbling window $w in (2, 4, 6, 8, 10)
start $s at $spos previous $sprev next $snext when true()
end $e at $epos previous $eprev next $enext when true()
return $sprev, $sprev,

some $name in (1 to 10)
satisfies $name