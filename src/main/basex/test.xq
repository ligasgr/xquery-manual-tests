declare
%rest:path("/test")
function local:login() {
    <test />
};

declare %rest:path("/test", "test2") function local:login2() {<test/>};
local:login()