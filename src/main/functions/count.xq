declare namespace fn = "http://www.w3.org/2005/xpath-functions";
declare namespace my = "http://www.w3.org/2005/xpath-functions/math";

declare variable $functions external;

for $function in $functions/functions/function/name
order by $function
return fn:concat($function, fn:starts-with('a','c','d'))