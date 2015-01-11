import module namespace local = 'http://www.w3.org/2005/xquery-local-functions' at 'dup_fun.xq';

declare variable $local:x := 'aaaaa';

declare function local:xx() {
'x'
};

local:x(),$local:x
