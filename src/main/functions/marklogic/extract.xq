declare namespace html = "http://www.w3.org/1999/xhtml";

declare variable $marklogicPubsDirectory external;

declare function local:getFunctionsFromFile($file) {
	let $functionDetailsStartingPosition := fn:doc($file)//html:b[text() = 'Function Detail'][1]
	for $functionNameLink in $functionDetailsStartingPosition/ancestor::html:tr/following-sibling::html:tr[1]/html:td/html:table/html:tr/html:td/html:table/html:tr/html:td/html:a
	let $nextRows := $functionNameLink/parent::html:td/parent::html:tr/following-sibling::html:tr
	let $functionName := $functionNameLink/fn:string(@id)
	let $returnType := local:getResultType(local:getLastRow($nextRows))
	for $argumentList in local:getArgumentsLists(local:getArguments($nextRows))
	return
		<function>
			<prefix>{fn:substring-before($functionName, ":")}</prefix>
			<name>{fn:substring-after($functionName, ":")}</name>
			<arity>{$argumentList/arity/text()}</arity>
			<arguments>
				{
					fn:normalize-space(fn:string-join($argumentList/argument, ", "))
				}
			</arguments>
			<returnType>{$returnType}</returnType>
		</function>
};

declare function local:getArgumentsLists($arguments) {
	for $argument at $pos in $arguments
	return
		if (fn:starts-with($argument, '[') and fn:not(fn:starts-with($arguments[$pos - 1], '[')))
		then
			(
				local:getArgumentsList(fn:subsequence($arguments, 1, $pos - 1)),
				local:getArgumentsList((fn:subsequence($arguments, 1, $pos - 1), $argument))
			)
		else if (fn:starts-with($argument, '['))
		then local:getArgumentsList((fn:subsequence($arguments, 1, $pos - 1), $argument))
		else if ($pos eq fn:count($arguments))
			then local:getArgumentsList(fn:subsequence($arguments, 1, $pos))
			else ()

};

declare function local:getArgumentsList($arguments) {
	<argumentList>
		<arity> {fn:count($arguments)} </arity>
		{
			for $argument in $arguments
			return
				<argument>
					{
						if (fn:starts-with($argument, '['))
						then fn:substring($argument, 2, fn:string-length($argument) - 2)
						else $argument
					}
				</argument>
		}
	</argumentList>
};

declare function local:getArguments($nextRows) {
	let $allRows := local:getAllButLastRow($nextRows)
	for $row in $allRows
	for $argument in $row/html:td[fn:not(fn:empty(text()))]
	let $normalizedArgument := fn:normalize-space(fn:replace($argument/text(), '#x160', ''))
	return
		if (fn:ends-with($normalizedArgument, ','))
		then fn:substring($normalizedArgument, 0, fn:string-length($normalizedArgument))
		else $normalizedArgument
};

declare function local:getAllButLastRow($nextRows) {
	let $count := fn:count($nextRows)
	for $row at $pos in $nextRows
	return if ($pos ne $count) then $row else ()
};

declare function local:getResultType($lastRow) {
	let $resultTypeUnstrippedText := $lastRow/html:td[fn:not(fn:empty(text()))][1]
	return fn:replace(fn:normalize-space(fn:replace($resultTypeUnstrippedText/text(), '&#xA0;', '')), '\) as ', '')
};

declare function local:getLastRow($nextRows) {
	let $count := fn:count($nextRows)
	for $row at $pos in $nextRows
	return if ($pos eq $count) then $row else ()
};

let $docsPath := fn:concat($marklogicPubsDirectory, '/pubs/apidocs/')
let $files := (
	'AdminBuiltins.html',
	'AppServerBuiltins.html',
	'Classifier.html',
	'DebugBuiltins.html',
	'Document-Conversion.html',
	'DurationDateTimeBuiltins.html',
	'Extension.html',
	'map.html',
	'MathBuiltins.html',
	'ProfileBuiltins.html',
	'SchemaBuiltins.html',
	'Search.html',
	'Security.html',
	'Semantics.html',
	'ServerMonitoring.html',
	'SpellBuiltins.html',
	'TransactionBuiltins.html',
	'UpdateBuiltins.html',
	'AccessorBuiltins.html',
	'AnyURIBuiltins.html',
	'BooleanBuiltins.html',
	'ContextBuiltins.html',
	'ErrorTrace.html',
	'Higher-Order.html',
	'NodeBuiltins.html',
	'NumericBuiltins.html',
	'QNameBuiltins.html',
	'SequenceBuiltins.html',
	'StringBuiltins.html',
	'XSLTBuiltins.html'
)
return <functions>
	{
		for $file in $files
		for $function in local:getFunctionsFromFile(fn:concat($docsPath, $file))
		order by $function/prefix, $function/name, $function/arity
		return $function
	}
</functions>