xquery version "1.0";
declare default function namespace "http://www.w3.org/2005/xquery-local-functions";

declare variable $x := 'x';

declare function test($x) {
let $x := 'z'
return $x
};


let $x := 'y'
return local:test($x)
