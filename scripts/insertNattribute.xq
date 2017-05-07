for $f in collection("catullus-cts")//*:TEI/*:text//*[not(@n)]
let $name := $f/name()
let $name2 := $name||(count($f/preceding-sibling::*/$name)+1)
return insert node attribute n {$name2} into $f