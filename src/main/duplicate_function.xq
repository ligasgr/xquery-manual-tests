module namespace dupl = 'xyz';
declare function dupl:ab($b as xs:integer) as xs:string {()};
declare function dupl:aa($a) {(dupl:ab($a/val/text()))};
