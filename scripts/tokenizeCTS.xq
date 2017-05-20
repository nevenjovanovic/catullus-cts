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

declare function local:return_cts_range($db , $doc , $limits ){
  (: Kayessian method of node-set intersection :)
  (: formula: $ns1[count(.| $ns2)=count($ns2)] :)
  (: XPath 2.0 version :)
  (: Source: Dimitre Novatchev, http://stackoverflow.com/questions/3428104/selecting-siblings-between-two-nodes-using-xpath :)
  (: TODO: what if limit2 precedes limit1? :)
  $limits[1] ,
  for $d in collection($db)//*[ends-with(@n,$doc)]
  return $d//*[. >> $d//*[.=$limits[1]] ]
        intersect 
      $d//*[ $d//*[.=$limits[1]]
    /following-sibling::*[.=$limits[2]]
  >> . ] ,
  $limits[2]
};

declare function local:cts_open_range($db1 , $db2 , $urn1 , $urn2){
  local:return_cts_range($db2 , $urn1 ,
  ( for $cts_limit in tokenize($urn2, "-")
  return local:cts_open($db1, $db2, $urn1, $cts_limit) ) )
};

(: given a two-part cts sequence, retrieve relevant doc and node in the index db :)
(: from the index db, retrieve node in the main db :)
declare function local:cts_open ($db1 , $db2 , $urn1 , $urn2 ){
  if (contains($urn2, "-")) then local:cts_open_range($db1 , $db2 , $urn1 , $urn2)
  else
  let $urn_all := $urn1 || ":" || $urn2
  let $idx := collection($db1)//doc[ends-with(@n , $urn1)]
  let $idx_locus := $idx/cts[urn=$urn2]/dbid/string()
  return if ($idx_locus) then db:open-id($db2, xs:int($idx_locus))
  else element p { "There is no URN " || $urn_all || " in our collection." }
};

declare function local:cts_open_doc ($db1 , $db2 , $urn ){
  let $idx := collection($db1)//doc[ends-with(@n , $urn)]
  let $idx_locus := $idx/cts[1]/dbid/string()
  return if ($idx_locus) then db:open-id($db2, xs:int($idx_locus))
  else element p { "There is no URN " || $urn || " in our collection." }
};

declare function local:cts_return_doc ($cts_last) {
  if (count($cts_last) = 2) then
  local:cts_open("catullus-cts-idx2" , "catullus-cts" , $cts_last[1] , $cts_last[2])
  else if (count($cts_last) = 1) then 
  local:cts_open_doc("catullus-cts-idx2" , "catullus-cts" , $cts_last)
  else element p { "The URN does not correspond to anything in our collection!" }
};
for $ctsurn in ("urn:cts:latinLit:phi0472.phi001.heidelberg-lat2:div1.53.1.w4", "urn:cts:latinLit:phi0472.phi001.heidelberg-lat2:div1.53.1.w1-div1.53.1.w4" , "abcdef", 23456, "urn:cts:latinLit:phi0472.phi001.heidelberg-lat2")
return local:cts_tokenize($ctsurn)