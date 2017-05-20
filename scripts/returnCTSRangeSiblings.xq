declare function local:return_cts_range($db , $doc , $limits){
  (: Kayessian method of node-set intersection :)
  (: formula: $ns1[count(.| $ns2)=count($ns2)] :)
  (: Source: Dimitre Novatchev, http://stackoverflow.com/questions/3428104/selecting-siblings-between-two-nodes-using-xpath :)
  for $d in collection($db)//*[@n=$doc]
  return $d//*[.=$limits[1]]
                  /following-sibling::*
                        [count(.|$d//*[.=$limits[1]]
                            /following-sibling::*
                            /preceding-sibling::*)
                         = 
                         count($d//*[.=$limits[1]]
                            /following-sibling::*[.=$limits[2]]
                            /preceding-sibling::*)]
};

let $limits := (<w xmlns="http://www.tei-c.org/ns/1.0" n="w3">quem</w> ,
    <w xmlns="http://www.tei-c.org/ns/1.0" n="w6">corona</w> )
let $doc := "urn:cts:latinLit:phi0472.phi001.heidelberg-lat2"
return local:return_cts_range("catullus-cts", $doc , $limits)