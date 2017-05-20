import module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull" at "../scripts/repo/catull.xqm";
declare function local:record_path($node){
  let $urnsubstring := string-join($node/ancestor-or-self::*[@n and not(@type=("edition", "translation") or name()="body")]/@n, ".")
  return $urnsubstring
};
declare function local:indexurns() { (: list all URNs :) 
for $t in collection("catullus-cts")//*:text/*:body/*:div 
let $texturns := for $id in $t//*[@n] 
let $preceding := $id/preceding-sibling::*[1][@n and name()=$id/name()]
let $following := $id/following-sibling::*[1][@n and name()=$id/name()]
let $parent := $id/parent::*[@n]
let $child := $id/*[@n][1]
 
let $baseurn2 := $id/ancestor::*:div[@type=("edition","translation")]/@n 
return element cts {  
  element urn { local:record_path($id) }, 
  element dbid {  db:node-id($id) } , 
  element ctsprev { local:record_path($preceding)} , 
  element dbidprev { db:node-id($preceding) } , 
  element ctsfol { local:record_path($following)} , 
  element dbidfol { db:node-id($following) } , 
  element ctsparent { local:record_path($parent) } , 
  element dbidparent { db:node-id($parent) } , 
  element ctschild {local:record_path($child) } , 
  element dbidchild { db:node-id($child) } } 
let $baseurn3 := $t/@n 
return element doc {  
$baseurn3 , 
element textgroup { catull:textgroup-from-urn(data($baseurn3)) },  
element work { catull:work-from-urn2($baseurn3) },  
$texturns } }; 
let $list := element idx { local:indexurns() } 
let $address := replace(file:base-dir(), "scripts/", "indices/catullus-cts-idx4.xml")
return file:write($address , $list)