(: LatTy :)
(: List available CITE Body URNs :)
import module namespace rest = "http://exquery.org/ns/restxq";

import module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull" at "../../repo/catull.xqm";


declare namespace page = 'http://basex.org/examples/web-page';

declare variable $title := 'Catulli c. 53 - CTS indiculus';
declare variable $content := "Display available CTS URNs in a digital collection of versions of Catullus's poem 53.";
declare variable $keywords := "Latin literature, CTS / CITE architecture, digital scholarly edition, XML";



(:~
 : This function returns an XML response message.
 :)
declare
  %rest:path("catullus/urnlist")
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
  function page:catulluslisturn()
{
  (: HTML template starts here :)

<html>
{ catull:htmlheadserver($title, $content, $keywords) }
<body text="#000000">

<div class="jumbotron">
<h1><span class="glyphicon glyphicon-th" aria-hidden="true"></span>{ $title }</h1>
<div class="container-fluid">
<div class="col-md-6">
<p class="catull-silver">URN in <a href="https://doi.org/10.17605/OSF.IO/DBF73">Atomic philology and parallel philology - Catullus 53 as a CTS editions collection</a> (DOI 10.17605/OSF.IO/DBF73), { current-date() }.</p>
<p><a href="http://orcid.org/0000-0002-9119-399X">Neven Jovanović</a>.</p>
<p>CTS URN indiculi in collectione editionum Catulli carminis 53.</p>
<p>Functio nominatur: {rest:uri()}.</p>
</div>
<div class="col-md-6">
{ catull:infodb('catullus-cts') }
</div>
</div>
</div>
<div class="container-fluid">
<blockquote class="croala">
	
	{ catull:editions_list() }
  
  
</blockquote>
     <p/>
     </div>
<hr/>
{ catull:footerserver() }

</body>
</html>
};

return
