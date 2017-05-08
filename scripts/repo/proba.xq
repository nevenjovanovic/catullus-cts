import module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull" at "catull.xqm";
(: latty:open-urn("urn:cts:latty:aemilianus01.latty2570222.latty-lat1:body1.div5.lg2.l52") :)
for $urns in ("urn:cts:latinLit:phi0472.phi001:11.6", "urn:cts:latinLit:phi0472.phi001:15")
return catull:test-urn($urns)