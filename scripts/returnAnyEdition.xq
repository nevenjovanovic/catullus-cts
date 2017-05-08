import module namespace functx = "http://www.functx.com" at "repo/functx.xqm";
declare function local:test-urn($urn){
  if (matches($urn, "urn:cts:latinLit:phi0472\.phi001:[0-9]+$") or matches($urn, "urn:cts:latinLit:phi0472\.phi001:[0-9]+\.[0-9]+")) then local:cts-open-general($urn)
  else if (matches($urn, "urn:cts:latinLit:phi0472\.phi001\..+:div[0-9]\..*")) then "open cts"
  else "CTS URN not found in the catullus-cts collection."
};
declare function local:cts-open-general($urn) {
(: if no edition is specified, open the fullest one in Latin :)
let $error := "CTS URN not found in the catullus-cts collection."
let $urnend := functx:substring-after-last($urn, ":")
let $urn2 := collection("catullus-cts-idx")//cts[starts-with(urn, "urn:cts:latinLit:phi0472.phi001.perseus-lat2:") and matches(urn, ":div[0-9]\.") and ends-with(urn, "." || $urnend)]
let $node := for $id in $urn2/dbid return xs:int($id)
return if (count($node) >= 1) then for $n in $node return db:open-id("catullus-cts", $n) else $error
};
for $urns in ("urn:cts:latinLit:phi0472.phi001:1.1", "urn:cts:latinLit:phi0472.phi001:1.55", "urn:cts:latinLit:phi0472.phi001:10.3", "urn:cts:latinLit:phi0472.phi001.heidelberg-lat0.meter:div1.53")
return local:test-urn($urns)