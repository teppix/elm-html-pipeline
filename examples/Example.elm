module Example exposing (..)

import Html.Pipeline exposing (..)
import Html.Pipeline.Nodes exposing (div, p, h1, h2, table, tr, td, input)


bg col =
    style "background" col


fg col =
    style "color" col


tableStyle =
    style "border" "2px solid black"


tableItems =
    [ ( "a1", "b1", "c1" )
    , ( "a2", "b2", "c2" )
    , ( "a3", "b3", "c3" )
    ]


myTable items =
    let
        row ( a, b, c ) =
            tr
                |> add
                    [ td |> text a
                    , td |> text b
                    , td |> text c
                    ]

        td_ =
            td |> style "color" "red" |> style "font-weight" "bold"
    in
        (table |> tableStyle)
            |> add
                [ tr
                    |> add
                        [ td_
                            |> text "column 1"
                        , td_
                            |> text "column 2"
                        , td_
                            |> text "column 3"
                        ]
                ]
            |> add (List.map row items)


italic : Modifier msg
italic =
    style "font-style" "italic"


padding : String -> Modifier msg
padding x =
    style "padding" x


view : Node msg
view =
    div
        |> class "content"
        |> add
            [ h1 |> text "simple heading"
            , h1 |> padding "1em" |> italic |> fg "#ccc" |> bg "#666" |> text "styled heading"
            , div
                |> add
                    [ p
                        |> text "paragraph"
                        |> newline
                        |> text "with line break"
                    , p |> text "second paragraph"
                    ]
            , h2 |> text "A table"
            , myTable tableItems
            ]


main =
    view |> toHtml
