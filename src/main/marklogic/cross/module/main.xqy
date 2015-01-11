xquery version "3.0";
import module namespace lib="lib" at "lib.xql";


$lib:foo,
lib:bar(),
try {
    "ad"
} catch ($e) {
    $e
}