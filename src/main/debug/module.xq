xquery version "1.0";

(:~
: User: ligasgr
: Date: 05/01/14
: Time: 19:48
: To change this template use File | Settings | File Templates.
:)

module namespace module = "module";
declare namespace xx = "dsfsdf";

declare variable $module:varlocal := 5;

declare function module:exec($i) {
    let $localvar := 'value'
	return if (not(string-length(string($i)) = 2))
	then
		let $x := 'x'
		return $x
	else
        $module:varlocal
};

declare function module:run() {
    if (1 eq 0) then 'valu'
    else  let $v := 'but' return $v
};