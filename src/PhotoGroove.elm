module PhotoGroove exposing (main)

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)



--model


urlPrefix =
    "http://elm-in-action.com/"


initialModel =
    [ { url = "1.jpeg" }
    , { url = "2.jpeg" }
    , { url = "3.jpeg" }
    ]


view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ]
            [ List.map viewThumbnail model
            ]
        ]


main =
    view initialModel


viewThumbnail thumbnail =
    img [ src urlPrefix ++ thumbnail.url ] []
