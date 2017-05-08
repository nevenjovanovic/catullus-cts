import module namespace catull = "http://www.ffzg.unizg.hr/klafil/catull" at "catull.xqm";
(: latty:open-urn("urn:cts:latty:aemilianus01.latty2570222.latty-lat1:body1.div5.lg2.l52") :)
for $urns in ("urn:cts:latinLit:phi0472.phi001:1.1", "urn:cts:latinLit:phi0472.phi001:1.55", "urn:cts:latinLit:phi0472.phi001:10.3", "urn:cts:latinLit:phi0472.phi001.heidelberg-lat0.meter:div1.53")
return catull:test-urn($urns)