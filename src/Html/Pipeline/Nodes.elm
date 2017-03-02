module Html.Pipeline.Nodes exposing (..)

{-| Library for building HTML elements by pipelining modifier functions

## Blocks
@docs div, span

## Form
@docs input

## Table
@docs table, tr, td

## Text flow
@docs br, p

## Headings
@docs h1, h2, h3, h4, h5, h6

## Lists
@docs ul, li

## Attributes
@docs href

## Events
@docs onClick, onClickTouch, onCheck, onInput
-}

import Html.Pipeline exposing (Node, Modifier, node, attr, strAttr)
import Html.Events as Events
import Json.Decode as Json


{-| div node
-}
div : Node msg
div =
    node "div"


{-| span node
-}
span : Node msg
span =
    node "span"


{-| input node
-}
input : Node msg
input =
    node "input"


{-| table node
-}
table : Node msg
table =
    node "table"


{-| tr node
-}
tr : Node msg
tr =
    node "tr"


{-| td node
-}
td : Node msg
td =
    node "td"


{-| h1 node
-}
h1 : Node msg
h1 =
    node "h1"


{-| h2 node
-}
h2 : Node msg
h2 =
    node "h2"


{-| h3 node
-}
h3 : Node msg
h3 =
    node "h3"


{-| h4 node
-}
h4 : Node msg
h4 =
    node "h4"


{-| h5 node
-}
h5 : Node msg
h5 =
    node "h5"


{-| h6 node
-}
h6 : Node msg
h6 =
    node "h6"


{-| ul node
-}
ul : Node msg
ul =
    node "ul"


{-| li node
-}
li : Node msg
li =
    node "li"


{-| br node
-}
br : Node msg
br =
    node "br"


{-| p node
-}
p : Node msg
p =
    node "p"


{-| href attribute
-}
href : String -> Modifier msg
href =
    strAttr "href"


{-| onInput
-}
onInput : (String -> msg) -> Modifier msg
onInput msg =
    attr (Events.onInput msg)


{-| onClick
-}
onClick : msg -> Modifier msg
onClick msg =
    attr (Events.onClick msg)


{-| onClickTouch
-}
onClickTouch : msg -> Modifier msg
onClickTouch message =
    on "touch touchstart" message


{-| onCheck
-}
onCheck : (Bool -> msg) -> Modifier msg
onCheck val =
    attr (Events.onCheck val)


{-| on
-}
on : String -> msg -> Modifier msg
on event message =
    attr <| Events.on event (Json.succeed message)
