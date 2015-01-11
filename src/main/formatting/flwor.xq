declare variable $a :=
    for $i in (1 to 10)
    let $i := $i + 1
    return
        $i;

sdf
