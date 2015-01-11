import module namespace fx = "http://www.functx.com" at "/functx.xq";


declare function local:fx($a, $b) {
	let $v := <x></x>
	return $fx:var
};

declare %private function local:fx($a) {
	let $v := <x></x>
	return $fx:var
};

declare %private function local:fx() {
	let $v := <x></x>
	return $fx:var
};

declare variable $x := 'x';
declare %private variable $x := 'x';

local:fx()
