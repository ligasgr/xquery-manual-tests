xquery version "1.0";

(:~
: User: ligasgr
: Date: 24/11/13
: Time: 16:06
: To change this template use File | Settings | File Templates.
:)

module namespace library = "library";
declare namespace z = 'library';


declare variable $z:x1 external;
declare variable $z:x2 external;
declare variable $library:x := 'x';

declare function library:x($z:x1, $z:x2) {
    ($z:x1, $z:x2)
};