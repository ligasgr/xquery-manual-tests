xquery version "1.0";

import module namespace module = "module" at "/home/ligasgr/IdeaProjects/empty/src/main/debug/module.xq";

declare variable $i external;

declare variable $another := 'sadfsdfsdf';

module:exec($i),
$another, module:run()