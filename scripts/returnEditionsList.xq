(: which editions are there? :)
declare function local:editions_list(){
  element div {
    attribute class { "table-responsive"},
  element table {
    attribute id { "catullus-urns"},
  attribute class { "table-striped table-hover table-centered"},
  element thead {
    element tr {
      element th { "Title"},
      element th { "Description"},
      element th { "Edition URN"},
      element th { "CTS URNs in edition" }
    }
  },
  element tbody {
for $w in collection("catullus-cts")//*:work
for $version in $w/*[*:label]
let $versionurn := data($version/@urn)
let $count := count(collection("catullus-cts-idx")//doc[@n=$versionurn]/cts)
return element tr {
  for $td in $version/*[name()=("ti:label", "ti:description")] return element td { normalize-space($td) },
    element td { element a {
      attribute href { "http://croala.ffzg.unizg.hr/basex/catullus/" || $versionurn } , 
      $versionurn } },
    element td { $count }
}
}
}
}
};
local:editions_list()