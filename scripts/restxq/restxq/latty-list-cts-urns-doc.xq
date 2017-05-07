(: LatTy :)
(: List available CITE Body URNs in a document :)
import module namespace rest = "http://exquery.org/ns/restxq";

import module namespace latty = "http://www.ffzg.unizg.hr/klafil/latty" at "../../repo/latty.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'LatTy: Latinitas Tyroliensis - CTS indiculus in textu';
declare variable $content := "Display available CTS URNs in a document from the LatTy digital collection.";
declare variable $keywords := "Neo-Latin literature, CTS / CITE architecture, Tyrolean Latin texts, XML";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("lattyctsurn/{$urn}")
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
  function page:lattyctslisturndoc($urn)
{
  (: HTML template starts here :)

<html>
{ latty:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p>URN in <a href="https://doi.org/10.5281/zenodo.571140">LatTy</a> (DOI 10.5281/zenodo.571140), { current-date() }. <a href="https://zenodo.org/badge/latestdoi/79109765"><img src="https://zenodo.org/badge/79109765.svg" alt="DOI"/></a></p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a> and <a href="http://orcid.org/0000-0001-5515-6545">Alexander R. Simrell</a>.</p>
<p>CTS URN indiculi in textu {$urn} e collectione Latinitatis Tyrolensis.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{latty:infodb('latty-cts')}
</div>
</div>
</div>
<div class="container-fluid">
{ latty:urn-header2($urn) }
<blockquote class="croala">
	
	{ latty:getcapabilitiesdoc($urn) }
  
  
</blockquote>
     <p/>
     </div>
<hr/>
{ latty:footerserver() }

</body>
</html>
};

return
