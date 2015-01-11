xquery version "1.0";
import module namespace fx = "http://www.functx.com" at "src/functx.xq";


declare variable $d as xs:date external;


fx:add-months($d, 2)