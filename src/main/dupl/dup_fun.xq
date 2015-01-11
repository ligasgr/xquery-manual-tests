module namespace local = "http://www.w3.org/2005/xquery-local-functions";

declare variable $local:x := 'z';

declare function local:x() {
 ()
};
