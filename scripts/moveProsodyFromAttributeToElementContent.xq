copy $doc := db:open("catullus-cts","phi0472/phi001/phi0472.phi001.heidelberg-lat0.meter.xml")
modify (
  for $met in $doc//*:w[@met]
  return replace value of node $met with $met/@met
) 
return $doc