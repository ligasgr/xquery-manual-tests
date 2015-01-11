declare namespace html = "http://www.w3.org/1999/xhtml";

declare function local:filteredOutFunctions($function, $functionName, $returnType) {
	if (fn:starts-with($functionName, 'op:'))
	then ()
	else
		<function>
			<prefix>{fn:substring-before($functionName, ":")}</prefix>
			<name>{fn:substring-after($functionName, ":")}</name>
			<arity>{fn:count($function//html:code[@class = "arg"])}</arity>
			<arguments>
				{
					fn:string-join(local:getArguments($function), ", ")
				}
			</arguments>
			<returnType>{$returnType}</returnType>
		</function>
};

declare function local:getArguments($function) {
	for $argument in $function//html:code[@class = "arg"]
	let $typicalType := $argument/following-sibling::html:code[@class = "type"][1]
	let $typeInTable := $argument/parent::node()/following-sibling::html:td[1]//html:code[@class = "type"]
	return fn:concat($argument/text(), " as ", ($typicalType/text(), $typeInTable/text()))
};

<functions>
	{
		for $function in //html:dd/html:div[@class = "exampleInner"]/html:div[@class = "proto"]
		let $functionName := $function//html:code[@class = "function"]/ text()
		let $returnType := $function//html:code[@class = "return-type"]/ text()
		order by $functionName
		return local:filteredOutFunctions($function, $functionName, $returnType)
	}
</functions>