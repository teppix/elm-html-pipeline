module Html.Pipeline.Nodes exposing (..)

{-| Library for building HTML elements by pipelining modifier functions

## Blocks
@docs div

## Form
@docs input

## Table
@docs table, tr, td

## Text flow
@docs br, p

## Headings
@docs h1, h2, h3, h4, h5, h6

## Attributes
@docs href

## Events
@docs onClick
-}

import Html.Pipeline exposing (Node, Modifier, node, attr, strAttr)
import Html.Events as Events


{-| div node
-}
div : Node msg
div =
    node "div"


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


{-| onClick
-}
onClick : msg -> Modifier msg
onClick msg =
    attr (Events.onClick msg)
