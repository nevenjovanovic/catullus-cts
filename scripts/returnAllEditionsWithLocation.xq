let $urn := "urn:cts:latinLit:phi0472.phi001:53.5"
let $urnend := "." || substring-after($urn , "phi001:")
for $cts in collection("catullus-cts-idx")//cts[ends-with(urn, "div1" || $urnend)]
let $dbid := xs:int($cts/dbid)
return element tr { 
element td { substring-after($cts/urn, "urn:cts:latinLit:phi0472.phi001.") },
element td { normalize-space(db:open-id("catullus-cts", $dbid)) }
}