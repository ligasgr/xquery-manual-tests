xquery version "1.0-ml";
module namespace test = "http://github.com/robwhitby/xray/test";
import module namespace assert = "http://github.com/robwhitby/xray/assertions" at "/xray/src/assertions.xqy";

import module namespace some-module = "http://some-module-to-test" at "/some-module-to-test.xqy";

declare %test:case function string-equality-example()
{
    let $foo := some-module:foo()
    return assert:equal($foo, "foo")
};

declare %test:case function multiple-assert-example()
{
    let $foo := some-module:foo()
    let $bar := "bar"
    return (
        assert:not-empty($foo, "an optional failure help message"),
        assert:equal($foo, "foo"),
        assert:not-equal($foo, $bar),
        assert:true(return-true())
    )
};

declare %test:ignore function ignored-test-example()
{
    let $foo := some-module:not-implemented-yet()
    return assert:equal($foo, <foo/>)
};