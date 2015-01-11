import module namespace xyz = 'xyz' at 'src/duplicate_function.xq';
declare namespace dupl = 'xyz';

declare function dupl:a() {
    ()
};

declare function dupl:a($a, $b) {
    ()
};

declare function dupl:a($a, $b)

xyz:a()