declare variable $docName as xs:string external;
declare variable $maximumDelay as xs:integer external;
declare variable $shippingDelay as xs:integer external;
declare variable $country as xs:string external;

declare function local:calculateReceivedIn($delay as xs:integer)
{
    let $receivedIn := ($delay + $shippingDelay)
    return ($receivedIn)
};

declare function local:getPrice($minnowElement as element(minnow)) as xs:string
{
    if ($country = 'Mexico') then
        (concat((data($minnowElement/international-prices/price[@denomination = "peso"]))
                , " Pesos"))

    else if ($country = 'Canada') then
        (concat(
                (data($minnowElement/international-prices/price[@denomination = "canadian-dollar"]))
                , " Canadian Dollars"))

    else if ($country = 'United States') then
            (concat((data($minnowElement/international-prices/price[@denomination = "dollar"]))
                    , " Dollars"))

        else
            (concat((data($minnowElement/international-prices/price[@denomination = "euro"]))
                    , " Euros"))
};

for $minnows in doc($docName)//minnows
return
    <div class="filterResults">
        <div class="brand">
            Brand: {data($minnows/@brand)}
        </div>
        <div class="size">
            Size: {data($minnows/@size)} inches
        </div>
        {
            for $minnow in $minnows/minnow
            where $minnow/availability/shipping/delay <= $maximumDelay
            return
                <div class="singleFilterResult">
                    <div class="color">
                        Color: {data($minnow/@color)}
                    </div>
                    <div class="shippingInfo">
                        <div class="receivedIn">
                            Received in {local:calculateReceivedIn($minnow/availability/shipping/delay)} day(s)
                        </div>
                        <div class="price">
                            {local:getPrice($minnow)}
                        </div>
                    </div>
                </div>
        }
    </div>