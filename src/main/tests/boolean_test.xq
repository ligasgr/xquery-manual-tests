xquery version "1.0";

declare variable $b as xs:boolean external;

if ($b) then "yep" else "nope"