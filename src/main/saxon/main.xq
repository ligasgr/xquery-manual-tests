xquery version "1.0";
import module namespace lib = 'library' at 'src/saxon/library.xq';
declare namespace z = 'library';

(:~
: User: ligasgr
: Date: 24/11/13
: Time: 16:05
: To change this template use File | Settings | File Templates.
:)

declare variable $z:x1 external;
declare variable $z:x2 external;

try {
	'sdfsdf'
} catch * {