# A simple CTS URN index for LatTy

We start from a list of document URNs in the `latty-cts` database: [croala.ffzg.unizg.hr/basex/lattycts/urnlist](http://croala.ffzg.unizg.hr/basex/lattycts/urnlist).

The list provides a count of CTS URNs in each document. If we follow a number after a document URN, for example, [urn:cts:latty:reinthaler01.latty2689432.latty-lat1](http://croala.ffzg.unizg.hr/basex/lattyctsurn/urn:cts:latty:reinthaler01.latty2689432.latty-lat1) (it has 357 URNs), a list of all available URNs will open.

If we follow links from that list, we will come to a document "node" -- to all the words that are cited under a specific CTS URN. Some of the nodes cite whole passages (and even texts), some cite individual words.

## Examples

[urn:cts:latty:reinthaler01.latty2689432.latty-lat1:body1.div3.head1](http://croala.ffzg.unizg.hr/basex/latty/urn:cts:latty:reinthaler01.latty2689432.latty-lat1:body1.div3.head1) - retrieves content of the heading from the third section (division) of the document `urn:cts:latty:reinthaler01.latty2689432.latty-lat1`. *Note* that just deleting final sections of the URN (in the URL shown in the address bar of the browser) takes us up in the hierarchy of the document. From the heading we may "jump" to the whole third section, or even to the whole body of the document.

[urn:cts:latty:reinthaler01.latty2689432.latty-lat1:body1.div3.lg2.l6](http://croala.ffzg.unizg.hr/basex/latty/urn:cts:latty:reinthaler01.latty2689432.latty-lat1:body1.div3.lg2.l6) - retrieves content of the sixth verse from the second strophe in the third section of the document `urn:cts:latty:reinthaler01.latty2689432.latty-lat1`.

[urn:cts:latty:sonhovius01.latty2712189.latty-lat1:body1.div1.div3.sp2.note3](http://croala.ffzg.unizg.hr/basex/latty/urn:cts:latty:sonhovius01.latty2712189.latty-lat1:body1.div1.div3.sp2.note3) - retrieves content of the third note annotating the second speech of the third subsection of the first section of the document `urn:cts:latty:sonhovius01.latty2712189.latty-lat1`.

## Databases

This system consists of two databases. The first one, `latty-cts`, holds the XML files in which each relevant (citable) node has an `n` attribute with a value of the node name and the number of its sequence inside the upper-level node. The second database, `latty-cts-idx`, holds the CTS URNs together with the "node ids", that is, identification numbers of each relevant (citable) node in the `latty-cts` database.

The `latty-cts` database is created by running the [create-latty.bxs](https://github.com/nevenjovanovic/latty-cts/blob/master/bxs/create-latty.bxs) script in the `bxs` directory.

The `latty-cts-idx` database is created from the `latty-cts-index.xml` file in the `indices` directory. This file, which is specific to each system (and therefore not under source control), is created locally by running the [create-latty-index-xml.bxs](https://github.com/nevenjovanovic/latty-cts/blob/master/bxs/create-latty-index-xml.bxs) script. From that XML source, the [create-latty-idx.bxs](https://github.com/nevenjovanovic/latty-cts/blob/master/bxs/create-latty-idx.bxs) script creates the database.

## XQueries and functions

The pages with lists of CTS URNs are created by two types of XQuery functions. The RESTXQ scripts create the pages, and XQuery functions from the [latty.xqm](https://github.com/nevenjovanovic/latty-cts/blob/master/scripts/repo/latty.xqm) module retrieve the variable data which are the main content of these pages.

### Description of functions from the latty.xqm module

`latty:getcapabilitiesdoc` -- retrieve a list of available CTS URNs in a document from the collection; the document is identified by its URN.

`latty:open-urn` -- retrieve contents of a node described by a CTS URN. If there is no such URN in the collection, report an error.

`latty:listurns3` -- for each document in the collection, report its base URN (its top CTS URN address) and the count of its available CTS URNs. Format the list as a table.

Other functions are earlier experiments, or helpers for producing parts of the LatTy template page.

