copy $doc := db:open("catullus-cts","phi0472/phi001/phi0472.phi001.heidelberg-lat0.sentence.xml")
modify (
  for $met in $doc//*:w[@ana]
  return replace value of node $met with $met/@ana
) 
return $doc