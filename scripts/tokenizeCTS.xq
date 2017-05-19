declare function local:cts_tokenize($cts){
  let $ctsstring := string($cts)
  return if (contains($ctsstring, ":")) then element tr { 
  element td { $ctsstring }, 
  element td { local:cts_analyze(tokenize($ctsstring, ":")) }
}
  else element p { $cts || " is not a well-formed URN!" }
};
declare function local:cts_analyze($cts){
  if ($cts[1]="urn" and $cts[2] = "cts" and $cts[3] = ("latinLit", "croala", "latty")) then local:cts_return_doc($cts[position() > 3])
  else "This URN is not part of our collections."
};
declare function local:cts_return_doc ($cts_last) {
  if (count($cts_last) = 2) then
  let $idx := collection("catullus-cts-idx2")//doc[ends-with(@n , $cts_last[1])]
  let $idx_locus := $idx/cts[urn=$cts_last[2]]/dbid/string()
  return db:open-id("catullus-cts", xs:int($idx_locus))
  else if (count($cts_last) = 1) then 
  let $idx := collection("catullus-cts-idx2")//doc[ends-with(@n , $cts_last[1])]
  let $idx_locus := $idx/cts[1]/dbid/string()
  return db:open-id("catullus-cts", xs:int($idx_locus))
  else element p { "The URN does not correspond to anything in our collection!" }
};
for $ctsurn in ("urn:cts:latinLit:phi0472.phi001.heidelberg-lat2:div1.53.1.w6", "abcdef", 23456, "urn:cts:latinLit:phi0472.phi001.heidelberg-lat2")
return local:cts_tokenize($ctsurn)