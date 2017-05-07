(: Catullus Carmen 53 CTS :)
(: List available CTS URNs in a document :)
import module namespace rest = "http://exquery.org/ns/restxq";

import module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull" at "../../repo/catull.xqm";

declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Atomic philology and parallel philology - Catullus 53 as a CTS editions collection: CTS URNs in a document';
declare variable $content := "Display available CTS URNs in a document from the Catullus 53 digital collection.";
declare variable $keywords := "Latin literature, CTS / CITE architecture, Catullus, scholarly edition, digital philology, XML";

(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("catullusurn/{$urn}")
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
  function page:catulluslisturndoc($urn)
{
  (: HTML template starts here :)

<html>
{ catull:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>URN in <a href="https://doi.org/10.17605/OSF.IO/DBF73">Atomic philology and parallel philology - Catullus 53 as a CTS editions collection</a> (DOI 10.17605/OSF.IO/DBF73), { current-date() }. CTS URNs in a document.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a>.</p>
<p>CTS URN indiculi in textu {$urn} e collectione editionum Catulli carminis 53.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{catull:infodb('catullus-cts')}
</div>
</div>
</div>
<div class="container-fluid">
{ catull:urn-header2($urn) }
<blockquote class="croala">
	
	{ catull:getcapabilitiesdoc($urn) }
  
  
</blockquote>
     <p/>
     </div>
<hr/>
{ catull:footerserver() }

</body>
</html>
};

return
