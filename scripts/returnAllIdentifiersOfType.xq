import module namespace functx = "http://www.functx.com" at "functx.xqm";
import module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull" at "catull.xqm";
declare function local:search-urn-type($search) {
  let $result :=
  element r {
for $cts in collection("catullus-cts-idx")//cts
let $suburn := functx:substring-after-last($cts/urn/string(), ":")
return $cts/urn[contains($suburn, $search)]
 }
 for $urn in $result/urn
 return element tr {
   element td { $urn/string()},
   element td { normalize-space(catull:open-urn($urn/string())) }
 }
};
local:search-urn-type(".com")