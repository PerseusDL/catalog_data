xquery version "3.1";


import module namespace system = "http://exist-db.org/xquery/system";
import module namespace xmldb = "http://exist-db.org/xquery/xmldb";
import module namespace util = "http://exist-db.org/xquery/util";
 
declare namespace mods="http://www.loc.gov/mods/v3";
declare namespace mads="http://www.loc.gov/mads/v2";


declare function local:subject-index()
{
    let $collection := '/db/PerseusCatalogData/mods'
    let $subjects := collection($collection)//mods:subject
    let $index-recs :=
    for $subject in $subjects
      let $topicLabels := for $child in $subject/child::* return normalize-space($child)
      let $label := string-join($topicLabels, '--')
      let $key := $label
      group by $label
      order by $label
      return
      <subject count="{count($subject)}" key="{util:hash($label[1], 'sha1')}">
       <label>{ $label[1] }</label>
      
         { for $mods in $subject/ancestor::mods:mods
           let $label :=
                 if ($mods/mods:titleInfo[@type='uniform']) then
                     normalize-space($mods/mods:titleInfo[@type='uniform'][1])
                 else normalize-space($mods/mods:titleInfo[1])
           return
             <version id="{xs:string($mods/mods:identifier[@type='ctsurn'])}">
                 <label>{ $label }</label>
             </version> 
         }
      </subject>         
      
    return
        <subjects count="{count($index-recs)}">{ $index-recs }</subjects>      
};

let $removeCollection :=
    if (xmldb:collection-available('/db/PerseusCatalogData/indexes/subjects'))
        then xmldb:remove('/db/PerseusCatalogData/indexes/subjects')
    else ()
let $createCollection := xmldb:create-collection('/db/PerseusCatalogData/indexes', 'subjects')

for $subject in local:subject-index()/subject
let $docname := string-join(($subject/@key, 'xml'),'.')
return
    xmldb:store('/db/PerseusCatalogData/indexes/subjects', $docname, $subject)
