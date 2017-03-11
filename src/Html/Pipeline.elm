module Html.Pipeline exposing (Node, Modifier, choice, applyIf, applyMaybe, id, class, styles, style, text, newline, add, html, node, toHtml, strAttr, attr, boolProperty, for, map)

{-| Library for building HTML elements by pipelining modifier functions

# Constructors
@docs node

# Render
@docs toHtml

# Modifiers

## Add content
@docs add, html, text, newline

## Attributes
@docs id, class, style, styles, strAttr, attr, boolProperty

## Attribute helpers
@docs for

# Conditionals
@docs applyIf, choice, applyMaybe

# Types
@docs Node, Modifier

# Transforms
@docs map
-}

import Html as H
import Html.Attributes as HA
import Json.Encode as Json


{-| Base type for chainable html commands
-}
type alias Node msg =
    { name : String
    , id : Maybe String
    , attrs : List ( String, String )
    , classes :
        List String
    , content : List (Content msg)
    , attributes : List (H.Attribute msg)
    }


type Content msg
    = NodeContent (Node msg)
    | HtmlContent (H.Html msg)


{-| Function signature for Node transform functions
-}
type alias Modifier msg =
    Node msg -> Node msg


maybeToList : Maybe a -> List a
maybeToList m =
    case m of
        Just val ->
            [ val ]

        Nothing ->
            []


{-| Begin element
-}
node : String -> Node msg
node name =
    Node name Nothing [] [] [] []


{-| Render to html
-}
toHtml : Node msg -> H.Html msg
toHtml node =
    let
        id =
            maybeToList <| (Maybe.map HA.id) node.id

        class =
            [ HA.class <| String.join " " <| List.reverse node.classes ]
    in
        H.node
            node.name
            (id ++ class ++ node.attributes)
            (List.map contentToHtml node.content)


contentToHtml : Content msg -> H.Html msg
contentToHtml node =
    case node of
        NodeContent x ->
            toHtml x

        HtmlContent x ->
            x


{-| Add class
-}
class : String -> Modifier msg
class s h =
    { h | classes = (s :: h.classes) }


{-| Add custom string attribute
-}
strAttr : String -> String -> Modifier msg
strAttr key val node =
    { node | attributes = (HA.attribute key val) :: node.attributes }


{-| Add custom attribute
-}
attr : H.Attribute msg -> Modifier msg
attr value node =
    { node | attributes = value :: node.attributes }


{-| Add single style
-}
style : String -> String -> Modifier msg
style key value node =
    { node | attributes = (HA.style [ ( key, value ) ]) :: node.attributes }


{-| Add list of styles
-}
styles : List ( String, String ) -> Modifier msg
styles values node =
    { node | attributes = (HA.style values) :: node.attributes }


{-| Add a bool property
-}
boolProperty : String -> Modifier msg
boolProperty key node =
    { node | attributes = (HA.property key (Json.bool True)) :: node.attributes }


{-| Shorthand for the "for" attribute
-}
for : String -> Modifier msg
for forid =
    strAttr "for" forid


{-| Add Node element
-}
add : List (Node msg) -> Modifier msg
add c h =
    { h | content = h.content ++ (List.map NodeContent c) }


{-| Add Html element
-}
html : List (H.Html msg) -> Modifier msg
html c h =
    { h | content = h.content ++ (List.map HtmlContent c) }


{-| Set id of element
-}
id : String -> Modifier msg
id s h =
    { h | id = Just s }


{-| Add text element
-}
text : String -> Modifier msg
text t =
    html [ H.text t ]


{-| Add br element
-}
newline : Modifier msg
newline =
    add [ node "br" ]


{-| Apply fa or fb to val depending on value of cond
-}
choice : (a -> a) -> (a -> a) -> Bool -> (a -> a)
choice fa fb cond val =
    (if cond then
        fa
     else
        fb
    )
        val


{-| Conditionally apply f to val
-}
applyIf : (a -> a) -> Bool -> a -> a
applyIf f cond val =
    (choice f identity) cond val


{-| Conditionally apply modifier in Maybe
-}
applyMaybe : Maybe (a -> a) -> a -> a
applyMaybe mf =
    case mf of
        Just f ->
            f

        Nothing ->
            identity


{-| Map message type
-}
map : (a -> b) -> Node a -> Node b
map f n =
    let
        mapContent v =
            case v of
                NodeContent x ->
                    NodeContent (map f x)

                HtmlContent x ->
                    HtmlContent (H.map f x)

        mapAttribute =
            HA.map f
    in
        { n
            | content = List.map mapContent n.content
            , attributes = List.map mapAttribute n.attributes
        }
