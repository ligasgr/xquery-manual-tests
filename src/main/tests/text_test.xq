xquery version "1.0";
import module namespace fx = "http://www.functx.com" at "src/functx.xq";

(:~
: User: ligasgr
: Date: 14/10/13
: Time: 14:19
: To change this template use File | Settings | File Templates.
:)

declare variable $t as text() external;

fx:contains-word($t, 'xxx')