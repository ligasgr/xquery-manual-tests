declare namespace z = 'zzz';
declare variable $x external;

declare function local:x() {
	let $local:x := 'z'
	let $z:x := 'z'
	let $z:y := 'z'
	return $local:x
};

declare variable $sdfdsf := dsfdsf;
