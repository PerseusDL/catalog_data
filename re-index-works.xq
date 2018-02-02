xquery version "3.1";

import module namespace system = "http://exist-db.org/xquery/system";
import module namespace util = "http://exist-db.org/xquery/util";

import module namespace cts="http://perseus.tufts.edu/apps/PerseusCatalog/cts" 
  at "/db/apps/PerseusCatalog/modules/cts.xqm";
  
  
import module namespace config="http://perseus.tufts.edu/apps/PerseusCatalog/config" 
  at "/db/apps/PerseusCatalog/modules/config.xqm";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace http = "http://expath.org/ns/http-client"; 
declare namespace mods="http://www.loc.gov/mods/v3";
declare namespace mads="http://www.loc.gov/mads/v2";


declare function local:version-label($urn as xs:string) as xs:string {
    let $mods := collection('/db/PerseusCatalogData/mods')//mods:identifier[. = $urn and @type='ctsurn'][1]/ancestor::mods:mods
    return $mods/mods:titleInfo[1]/mods:title[1]
};

declare function local:work-label($urn as xs:string) as xs:string {
    let $cite-entry := doc('/db/PerseusCatalogData/cite/works.xml')//work[. = $urn]/ancestor::work
    return
        if ($cite-entry) then
            $cite-entry[1]/title-eng[1]
        else "[No Title]"
};

declare function local:works-by($authorid as xs:string) as element()* {
    let $rec := collection('/db/PerseusCatalogData/mads')//mads:identifier[.=$authorid]/ancestor::mads:mads
    let $related-work-ids := $rec/mads:extension/mads:identifier
    let $versionurns := 
      for $rid in $related-work-ids
      for $id in collection('/db/PerseusCatalogData/mods')//mods:identifier[. = $rid]/ancestor::mods:mods/mods:identifier[@type='ctsurn']
      return xs:string($id)
    return
    <worksby authorid="{$authorid}"> {
        for $urns in distinct-values($versionurns)
           let $workid := cts:full-work-id(cts:object($urns))
           let $work-label := local:work-label($workid)
           group by $workid
    return 
        <work ctsurn="{$workid}">
            <label>{ $work-label[1] }</label>
            { for $urn in $urns
              let $label := local:version-label($urn)
              return 
                 <edition ctsurn="{ $urn }">
                    <label>{ $label }</label>
                 </edition>  
                }
        </work>
    }</worksby>
};


let $removeCollection :=
    if (xmldb:collection-available('/db/PerseusCatalogData/indexes/worksby'))
        then xmldb:remove('/db/PerseusCatalogData/indexes/worksby')
    else ()
let $createCollection := xmldb:create-collection('/db/PerseusCatalogData/indexes', 'worksby')

for $authorid in distinct-values(collection($config:data-root)//mads:mads/mads:identifier[@type='citeurn'])
let $works := local:works-by($authorid)
let $docname := string-join((substring-after($authorid, 'urn:cite:perseus:'), 'worksby', 'xml'),'.')
return
    xmldb:store('/db/PerseusCatalogData/indexes/worksby', $docname, $works)
    