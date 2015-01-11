xquery version "1.0";
import module namespace fx = "http://www.functx.com" at "src/functx.xq";
declare namespace a = "b";

(:~
: User: ligasgr
: Date: 14/10/13
: Time: 20:38
: To change this template use File | Settings | File Templates.
:)

declare variable $a:a as text() external;

string($a:a)