declare function local:return_cts_range($db , $doc , $limits){
  (: Kayessian method of node-set intersection :)
  (: formula: $ns1[count(.| $ns2)=count($ns2)] :)
  (: XPath 2.0 version :)
  (: Source: Dimitre Novatchev, http://stackoverflow.com/questions/3428104/selecting-siblings-between-two-nodes-using-xpath :)
  for $d in collection($db)//*[@n=$doc]
  return $d//*[. >> $d//*[.=$limits[1]] ]
        intersect 
      $d//*[ $d//*[.=$limits[1]]
    /following-sibling::*[.=$limits[2]]
  >> . ]                
};

let $limits := (<w xmlns="http://www.tei-c.org/ns/1.0" n="w3">quem</w> ,
    <w xmlns="http://www.tei-c.org/ns/1.0" n="w6">corona</w> )
let $doc := "urn:cts:latinLit:phi0472.phi001.heidelberg-lat2"
return ($doc , $limits[1])