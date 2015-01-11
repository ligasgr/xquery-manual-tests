declare variable $functions external;

let $functionSignatures :=
	for $function in $functions/functions/function
	let $prefix := $function/prefix/text()
	let $name := $function/name/text()
	let $arity := $function/arity
	let $arguments := fn:normalize-space(if (fn:empty($function/arguments)) then 'null' else fn:concat('"', $function/arguments, '"'))
	let $returnType := $function/returnType
	return fn:concat('fnMap.putValue(ns("', $prefix, '"), bif("', $prefix, '", "', $name,'", ', $arity,', ', $arguments,', "', $returnType,'"));')
return fn:string-join($functionSignatures, '&#xa;')
