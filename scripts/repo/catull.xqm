module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull";
import module namespace functx = "http://www.functx.com" at "functx.xqm";

declare namespace tei = 'http://www.tei-c.org/ns/1.0';

(: helper function for header, with meta :)
declare function catull:htmlheadserver($title, $content, $keywords) {
  (: return html template to be filled with title :)
  (: title should be declared as variable in xq :)

<head><title> { $title } </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="{ $keywords }"/>
<meta name="description" content="{$content}"/>
<meta name="revised" content="{ current-date()}"/>
<meta name="author" content="Neven Jovanović, Alexander R. Simrell" />
<link rel="icon" href="/basex/static/gfx/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="/basex/static/dist/css/lattycts.css"/>
</head>

};

(: formatting - footer on solr :)
declare function catull:footerserver () {
let $f := <footer class="footer">
<div class="container">
<h3> </h3>
<h1 class="text-center"><span class="glyphicon glyphicon-leaf" aria-hidden="true"></span> <a href="http://solr.ffzg.hr/dokuwiki/doku.php/start">Croatica et</a> Tyrolensia</h1>
<div class="row">
<div  class="col-md-3">
<a href="http://www.ukf.hr/"><img src="/basex/static/gfx/ukflogo.gif"/></a></div> 
<div  class="col-md-6">
<p class="text-center"><a href="http://www.ffzg.unizg.hr"><img src="/basex/static/gfx/ffzghrlogo.png"/> Filozofski fakultet</a> Sveučilišta u Zagrebu</p> 
<p class="text-center">Ludwig Boltzmann <a href="http://neolatin.lbg.ac.at/">Institut für Neulateinische Studien, Innsbruck</a> <img src="http://lbicr.lbg.ac.at/files/sites/lbicr/images/bildlogo_farbe_weiss.jpg" width="60"/></p></div>
<div  class="col-md-3"><p  class="text-center"><a href="https://www.tirol.gv.at/bildung/wissenschaftsfonds/"><img src="/basex/static/gfx/tirollogo.png"/></a></p></div></div>
</div>
</footer>
return $f
};

declare function catull:infodb($dbname) {
  (: return info on croalabib db, with Latin field names :)
let $week := map {
  "name": "nomen",
  "documents": "documenta",
  "timestamp": "de dato"
}
return element table { 
attribute class { "pull-right"},
let $i := db:info($dbname)/databaseproperties
  for $n in ('name','documents','timestamp')
  return 
   element tr {
    element td { map:get($week, $n) } ,
    element td { $i/*[name()=$n] }
  }
}
};

declare function catull:listurns() {
(: list all URNs :)
for $t in collection("catullus-cts")//*:text
let $baseurn := element h1 { replace($t/@xml:base, ":$", "") }
let $texturns :=
for $id in $t//*[@n]
let $urnsubstring := string-join($id/ancestor-or-self::*[@n]/@n, ".")
let $baseurn2 := $id/ancestor::*:text/@xml:base
let $urn2 := $baseurn2 || $urnsubstring
return element li { 
element a { 
attribute href { $urn2 } , $urn2
}
}
return (
  $baseurn ,
  element ol {
  $texturns
}
)
};

(: list URNs using the index database :)

declare function catull:listurns2() {
  for $doc in collection("catullus-cts-idx")//doc
return element ol {
  for $cts in $doc//cts
  let $urn := $cts/urn/string()
  return element li { 
  element a {
    attribute href { "http://croala.ffzg.unizg.hr/basex/lattycts/" || $urn  },
    $urn
  }
}
}
};

(: return only number of URNs for each document :)

declare function catull:listurns3(){
  element div {
    attribute class { "table-responsive"},
  element table {
    attribute id { "latty-urns"},
  attribute class { "table-striped table-hover table-centered"},
  element thead {
    element tr {
      element th { "Author"},
      element th { "Title"},
      element th { "Document CTS URN"},
      element th { "Total count of URNs"}
    }
  },
  element tbody {
  for $doc in collection("catullus-cts-idx")//doc
  let $textgroup := normalize-space($doc/textgroup)
  let $work := normalize-space($doc/work)
let $baseurn := replace($doc/@xml:base, ":$", "")
return element tr {
  element td { $textgroup },
  element td { $work },
  element td { element a {
    attribute href { "http://croala.ffzg.unizg.hr/basex/lattyctsurn/" || $baseurn  },
    $baseurn
  } } ,
  let $cts := count($doc//cts)
  return element td { 
  element a {
    attribute href { "http://croala.ffzg.unizg.hr/basex/lattyctsurn/" || $baseurn  },
    $cts
  }
}
}
}
}
}
};

(: return author names or textgroup descriptions :)

declare function catull:textgroup-from-urn($cts){
  for $textgroup in collection("catullus-cts")//*:textgroup[@urn=substring-before($cts, ".")]
let $name := data($textgroup//*:groupname)
return if ($name) then normalize-space($name) else "Anonymus"
};

(: given a CTS URN, return title of the work :)
declare function catull:work-from-urn($cts){
  for $work in collection("catullus-cts")//*:work/*[@urn=functx:substring-before-last($cts, ":")]
let $name := data($work//*:label)
return if ($name) then normalize-space($name) else "sine titulo"
};

declare function catull:work-from-urn2($cts){
  for $work in collection("catullus-cts")//*:work/*[@urn=$cts]
let $name := data($work//*:label)
return if ($name) then normalize-space($name) else "sine titulo"
};

(: given a URN, open an indexed node :)

declare function catull:open-urn($urn){
  let $node := collection("catullus-cts-idx")//cts[urn=$urn] 
  let $dbid := xs:int($node/dbid/string())
  return if ($node) then db:open-id("catullus-cts", $dbid) else element p { "Not a valid URN in the catullus-cts collection!" }
};

(: for a given base URN, list all CTS URNs below it :)
declare function catull:getcapabilitiesdoc($baseurn){
  element h2 {},
element ol {
let $doc := collection("catullus-cts-idx")//doc[contains(@xml:base, $baseurn)]
for $cts in $doc//cts
let $urn := $cts/urn/string()
return element li { element a {
  attribute href { "http://croala.ffzg.unizg.hr/basex/latty/" ||  $urn },
  $urn
}
}
}
};

(: From a URN, return metadata on author and text as headings :)
declare function catull:urn-header($urn){
  let $doc := collection("catullus-cts-idx")//doc[cts/urn=$urn]
let $xmlbase :=  $doc/@xml:base
let $textgroup := $doc/textgroup
let $work := $doc/work
return element div {
  element h1 { replace($xmlbase, ":$", "") },
  element h2 { $textgroup || " ― " || $work }
}
};

(: given a doc URN without the colon at the end, retrieve a header with textgroup and work :)
declare function catull:urn-header2($urn){
  let $doc := collection("catullus-cts-idx")//doc[contains(@xml:base,$urn)]
let $textgroup := $doc/textgroup
let $work := $doc/work
return element div {
  element h1 { $urn },
  element h2 { $textgroup || " ― " || $work }
}
};

(: which editions are there? :)
declare function catull:editions_list(){
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
      attribute href { "http://croala.ffzg.unizg.hr/basex/catullus-urn/" || $versionurn } , 
      $versionurn } },
    element td { $count }
}
}
}
}
};