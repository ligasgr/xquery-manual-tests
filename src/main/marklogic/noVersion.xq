xquery version '1.0-ml';

declare %private function fun($par as xs:string) { $par };
declare private variable $var as xs:integer := 'var';
try {
    $var/namespace::*, binary {$var/binary()},
    validate as xs:boolean {fn:false()}
} catch ($e) {}