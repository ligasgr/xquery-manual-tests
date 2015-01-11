module namespace name = "my namespace";

declare function name:example($functionArgumentScopeVar) {
	"x"
};

declare function name:referencing() as xs:integer*{
	let $flworScopeVar := "anything"
	return name:example($flworScopeVar)
};

declare function app:helloworld($node as node (), $model as map ( * ), $name as xs
:string?) {
	if ($name) then
		<p>Hello {$name}!</p>
	else
		()
};