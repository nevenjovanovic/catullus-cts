# Producing CTS version of Tyrolean Neo-Latin texts

## Our collection
* Unlike the “classical” Greek and Latin literature (the corpus of works preserved from 750 BC to 500 AD), Neo-Latin texts do not have canonical (standard, widespread) citation schemes.  
* For our digital collection, this lack of established citation schemes has its advantages and disadvantages.  On the one hand, there are no complicated citation systems to be reproduced.  On the other hand, we have to develop and implement a citation scheme which will be machine actionable and ideally also understandable to humans.  
* To accomplish our goal we followed the guidelines of [CITE Architecture](http://cite-architecture.github.io/) and of the [CapiTainS tools suite](http://capitains.github.io/pages/guidelines) (for the directory structure and some naming conventions).

## Our scripts
* We created a database and edited our collection in BaseX.
* A list of all the XQuery scripts used and their descriptions can be found [here](https://github.com/nevenjovanovic/latty-cts/blob/master/scripts/scripts.md).  

## Cleaning up exisitng files
* We started with existing xml files of the Tyrolean texts.
* These files already contained some metadata which we used when possible.
* We standardized the 'key' attribute values from each author element for works with one author.
* We created these 'key' values for works with anonymous or multiple authors.  
* We inserted an 'encodingDesc' element for each work.  
* We inserted an 'xml:base' attribute to each text element which includes the citation up to the level of the edition:  `urn:cts:latty:aemilianus01.latty2570222.latty-lat1:` 
* In the above example `urn:cts:latty:` specifies that this is a urn citation following the cts protocol for a database called ‘latty,’  `aemilianus01.` refers to the textgroup, `latty2570222.` refers to the work, and `latty-lat1:` refers to the edition.  

## Departure from CapiTainS
* We followed the CapiTainS guidelines up to the level of the edition: 
`urn:cts:latty:aemilianus01.latty2570222.latty-lat1:`
* CapiTainS requires each element under the text node to have an 'n' attribute.
* Our editions have this 'n' attribute, but the value differs from other implementations.
* As previously noted, we are working with non-canonical texts.  There is no established citation scheme, and many people are not familiar with these texts.
* Instead of just using numbers, we used both the names of existing elements and their sequence in the document: instead of something like `2.6.2.2.6` we have `text.body.div2.div6.div2.div2.l6`
* The latter urn fragment suggests something about the semantic relationships of the segments and can help a reader have a somewhat clearer understanding of this citation.

## Creating the textgroup and work directories
* We used the 'xml:base' attribute to create texgroup and work directories.  
* The textgroup is a directory that contains works which belong to a single author or set of authors.  
* We created a separate textgroup for each work by an anonymous author rather than put them all together in one textgroup.  
* Inside each texgroup directory there is a work directory for each work in the textgroup.  There were no works with multiple editions in this collection, but our citation scheme does allow for this.  
* We moved the files into their appropriate directories.
* We created cts xml files for each textgroup and each work.  The cts xml files contain metadata about the textgroup or work.

## Validation 
* We used Oxygen to ensure that are files are valid TEI xml.
* The other schemas used to validate our files can be found [here](https://github.com/nevenjovanovic/latty-cts/tree/master/schemas)
* In Oxygen we validated our collection against textgroup.rng file.  This schema file contains additional rules about what can be in a textgroup
* We did catch a problem with our files.  We needed to declare the 'ti' namespace inside the textgroup.
* Next we validated our collection against the [HookTest](https://github.com/Capitains/HookTest).
* The HookTest validates the xml and directory structure.  It also ensures that all urns are valid and are pointing in the right direction.
