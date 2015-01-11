xquery version "1.0";
declare namespace xdmp = "http://marklogic.com/xdmp";
(:~
: User: ligasgr
: Date: 10/10/13
: Time: 16:48
: To change this template use File | Settings | File Templates.
:)

(: This is welcome.xqy :)
<big xmlns="http://www.w3.org/1999/xhtml">
    Welcome to { xdmp:product-name() }
    { xdmp:version() }
    { xdmp:product-edition() } Edition!
</big>