xquery version "1.0";

let $tested := <list>
	<item name="df">content &lt;</item>
	<item name="aa&nbsp;"/>
	<!--<item name="cc"/>-->
</list>
for $item in $tested//item
let $next := ($item/following-sibling::item[1])
return <x>{string($item/@name), '->', $next}</x>