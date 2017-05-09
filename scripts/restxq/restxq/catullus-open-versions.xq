(: Catullus CTS :)
(: For a CTS URN, return the all versions of a node :)
import module namespace rest = "http://exquery.org/ns/restxq";

import module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull" at "../../repo/catull.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Catullus 53 CTS';
declare variable $content := "For a generic CTS URN of Catullus 53, display all available passages from the collection of editions and versions.";
declare variable $keywords := "Latin literature, Catullus, CTS / CITE architecture, digital classics, digital philology, scholarly edition, XML";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("catullus-urn-versions/{$urn}")
  %output:method(
  "xhtml"
)
  %output:omit-xml-declaration(
  "no"
)
  %output:doctype-public(
  "-//W3C//DTD XHTML 1.0 Transitional//EN"
)
  %output:doctype-system(
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
)
  function page:catullusopenctsversions($urn)
{
  (: HTML template starts here :)

<html>
{ catull:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p class="catull-silver">A URN in <a href="https://doi.org/10.17605/OSF.IO/DBF73">Atomic philology and parallel philology - Catullus 53 as a CTS collection</a> (DOI 10.17605/OSF.IO/DBF73), { current-date() }. CTS URNs in an edition.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a>.</p>
<p>CTS URN <tt>{$urn}</tt> in editione Catulli carminis 53. Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{catull:infodb('catullus-cts')}
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	
	{ catull:list-all-versions($urn) }

</blockquote>
     <p/>
     </div>
<hr/>
{ catull:footerserver() }

</body>
</html>
};

return
