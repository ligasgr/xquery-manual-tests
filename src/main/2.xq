module namespace example = "example.xq";

declare default function namespace "example.xq";

declare variable $example:var1 := 'var1';
declare variable $var2 := 'var2';

declare function example:fun($example:par1) {
    let $example:local1 := 'local1'
    let $local2 := $example:var1
    let $local3 := $var1
    let $local3 := $example:var2
    let $local4 := $var2
    let $local5 := $example:par1
    let $local6 := $par1
    return $local6
};