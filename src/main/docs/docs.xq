(:~
xquery version "1.0";
:)
declare namespace b = "http://www.marklogic.com/ns/gs-books";

(:~ aaaa
 : @author Somebody
 : @param $options XQDoc generation options, e.g.:
 :)
declare variable $b:b as document-node() external;

(:~
 : Generated the an XQDoc XML document for the module provided
 : as parameter to this function.
 : In comparison to the single parameter version, this function does not
 : generate XQDoc for all language components. By default, the
 : following components are deactivated: XQuery comments, import
 : statements, variable declarations, function declarations, collection
 : declarations,  and index declarations. The second parameter is used to
 : enable the XQDoc generation of those components.
 :
 : @deprecated because I said so
 : @param $module The module (as string) for which to generate
 :  the XQDoc documentation.
 : @param $options XQDoc generation options, e.g.:
 : <pre>
 : &lt;enable xmlns="http://www.zorba-xquery.com/modules/xqdoc-options"
 :   comments="true"
 :   functions="true"
 :   indexes="true"
 : &gt;
 : </pre>
 : @return An element according to the xqdoc schema
 :  (<tt>http://www.zorba-xquery.com/modules/xqdoc.xsd</tt>).
 : @error zerr::ZXQD0002 if the xqdoc comments in the
 :  module contain invalid XML
 :)
declare %private function b:f($a) as item() {()};

declare %private function b:faa($a) as item() {()};

$b/b:books/b:book[1]/b:title/text(), b:f(1),
<b:sdfs></b:sdssf>