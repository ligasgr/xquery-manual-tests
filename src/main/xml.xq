xquery version "1.0";
module namespace time = "http://danmccreary.com/time";

(: general utilities for manipulating dates, times and durations
to import add the following line to your query or module:

import module namespace time = "http://danmccreary.com/time" at '../../../modules/time.xqm';
import module namespace time = "http://danmccreary.com/time" at 'xmldb:exist:///db/chase/modules/time.xqm';
:)

(: three letter months in upper case :)
declare variable $time:three-letter-months-uc := ('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC');

(: three letter months in title case :)
declare variable $time:three-letter-months-tc := ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

declare function time:substring-before-last-slash($in as xs:string?) as xs:string {
    if (matches($in, '/'))
    then replace($in, '^(.*)/.*', '$1')
    else ()
};

declare function time:substring-after-last-slash($in as xs:string?) as xs:string {
    replace($in, '^.*/', '')
};

declare function time:substring-before-last($in as xs:string?, $delim as xs:string) as xs:string {
    if (matches($in, $delim))
    then replace($in,
            concat('^(.*)', $delim, '.*'),
            '$1')
    else ''
};

(: converts dates from YYYYMM format to MMM-YY format :)
declare function time:us-dateTime($inany) as xs:string {
    let $in := xs:string($inany)
    (: months in title case :)
    let $month-seq-tc := $time:three-letter-months-tc
    (: let $month-seq-uc := ('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC') :)
    (: The new year is created by taking the $in, old date, and starting at the third char - get the next two chars  :)
    let $year := substring($in, 1, 4)
    let $new-month-int := xs:integer(substring($in, 6, 2))
    let $day-of-month := xs:integer(substring($in, 9, 2))
    let $new-month-name := $month-seq-tc[$new-month-int]
    let $time := substring($in, 12, 8)
    let $us-hours := time:us-hours-from-iso-hours($time)
    return concat($new-month-name, ' ', $day-of-month, ', ', $year, ' ', $us-hours)
};

declare function time:fmt-date($in as xs:string) as xs:string {
    let $year-number := substring($in, 1, 4)
    let $month-number := xs:integer(substring($in, 6, 2))
    let $month-name := $time:three-letter-months-lc[$month-number]
    let $day-number := substring($in, 9, 2)
    let $time := substring($in, 12, 5)
    return concat($month-name, ' ', $day-number, ' ', $year-number, ' ', $time)
};

(: moved to another module due to lack of jar file on AIX server
the return type of this function must not be specified
declare function time:render-fo($input-fo as node()) as element() {
let $pdf := xslfo:render($input-fo, "application/pdf", ())
return response:stream-binary($pdf, "application/pdf", "output.pdf")
};

:)

(: generic tool for listing the queries in a collection and when they were modified and created :)
declare function time:list-queries() as node() {
    let $collection := substring-after(time:substring-before-last-slash(request:get-uri()), '/rest')
    let $query-description-path := concat($collection, '/query-descriptions.xml')
    let $queries := doc($query-description-path)//query
    let $sorted-files :=
        for $file in xmldb:get-child-resources($collection)
        order by xs:dateTime(xmldb:last-modified($collection, $file)) descending
        return
            if (not($file = 'index.xq') and ends-with($file, '.xq'))
            then $file
            else ()

    return
        <div class="content">
            <p>XQuery files sorted by last-modified datetime</p>
            <table class="datatable span-24">
                <thead>
                    <tr>
                        <th class="span-5 row2">File</th>
                        <th class="span-10 row2">Description</th>
                        <th class="span-3 row2">Parms</th>
                        <th class="span-2 row2">Last Modified</th>
                        <th class="span-2 row2">Created</th>
                    </tr>
                </thead>
                {for $file at $count in $sorted-files
                let $query := $queries[file = $file]
                return
                    <tr>
                        {if ($count mod 2)
                        then attribute class {'odd'}
                        else attribute class {'even'}
                        }
                        <td style="text-align:left;"><a href="{$file}">{$file}</a></td>
                        <td style="text-align:left;">{$query/desc/text()}</td>
                        <td style="text-align:left;">{string-join($query//param/@name/string(), ', ')}</td>
                        <td style="text-align:left;">{time:us-dateTime(xmldb:last-modified($collection, $file))}</td>
                        <td style="text-align:left;">{time:us-dateTime(xmldb:created($collection, $file))}</td>
                    </tr>
                }
            </table>
            Test Status at <a href="/rest{$collection}/query-descriptions.xml">{$collection}/query-descriptions.xml</a>
        </div>
};

(: takes in a string like "13:29:45" and returns " 1:29:45pm" :)
declare function time:us-hours-from-iso-hours($iso-hours as xs:string) as xs:string {
    let $int := xs:integer(substring($iso-hours, 1, 2))
    return
        let $us-hours :=
            if ($int eq 0)
            then '12'

            else if ($int le 9)
            then concat(' ', substring($iso-hours, 2, 1))

            else if ($int le 12)
                then string($int)

                else string($int - 12)

        let $am-pm :=
            if ($int le 11)
            then 'am'
            else 'pm'

        return concat($us-hours, substring($iso-hours, 3, 8), $am-pm)
};

declare function time:day-of-week($date as xs:anyAtomicType?) as xs:integer? {
    if (empty($date))
    then ()
    else xs:integer((xs:date($date) - xs:date('1901-01-06'))
            div xs:dayTimeDuration('P1D')) mod 7
} ;

declare function time:day-of-week-abbrev-en($date as xs:anyAtomicType?) as xs:string? {
    ('Sun', 'Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat')[time:day-of-week($date) + 1]
} ;

(: input a dateTime and we return its age in a human readable format
based on the current date time.
Use user-friendly strings like "Today", "Yesterday"
:)
declare function time:recent-dateTime($in as xs:dateTime) as xs:string {
    let $in-str := xs:string($in)
    let $in-date := substring($in-str, 1, 10)
    let $in-time := substring($in-str, 12, 8)

    let $now := current-dateTime()
    let $now-str := xs:string($now)
    let $yesterday-str := xs:string($now - xs:dayTimeDuration('P1D'))
    let $now-date := substring($now-str, 1, 10)
    let $yesterday-date := substring($yesterday-str, 1, 10)

    let $duration-day :=
        if ($in-date = $now-date)
        then 'Today'
        else if (starts-with($in-date, $yesterday-date))
        then 'Yesterday'
        else concat(time:day-of-week-abbrev-en($in), ' ', $in-date)

    let $time := time:us-hours-from-iso-hours($in-time)
    return concat($duration-day, ' at ', $time)
};

declare function time:age($in as xs:dateTime) as xs:duration {
    let $now := current-dateTime()
    return $now - $in
};

(:~ convert the string of format PnYnMnDTnHnMnS.SS into days, hours, minutes and seconds :)
declare function time:age-fmt($in as xs:dateTime) as xs:string {
    let $duration := time:age($in)

    let $days := days-from-duration($duration)
    let $days-str := if ($days gt 0) then concat($days, ' days,') else ()
    let $hours := hours-from-duration($duration)
    let $hours-str :=
        if ($hours gt 0)
        then
            if ($hours gt 1)
            then concat($hours, ' hrs, ')
            else concat($hours, ' hr, ')
        else ()
    let $minutes := minutes-from-duration($duration)
    let $minutes-str := if ($minutes gt 0) then concat($minutes, ' min, ') else ()
    let $seconds := round(seconds-from-duration($duration))
    let $seconds-str := if ($seconds gt 0) then concat($seconds, ' sec') else ()

    return concat($days-str, $hours-str, $minutes-str, $seconds-str, ' ago')
};