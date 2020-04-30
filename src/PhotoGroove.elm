module PhotoGroove exposing (main)

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser



--model


urlPrefix =
    "http://elm-in-action.com/"


initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    }



-- view

view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ]
             -- List.map viewThumbnail model
             -- (List.map (\photo -> viewThumbnail model.selectedUrl photo) model.photos)
             (List.map (viewThumbnail model.selectedUrl) model.photos)
            , img [ class "large", src (urlPrefix ++ "large/" ++ model.selectedUrl) ]
                []

        ]


viewThumbnail selectedUrl thumbnail =
    --if selectedUrl == thumbnail.url then
    --    img [ src (urlPrefix ++ thumbnail.url)
    --     , class "selectedUrl"] []
    --else
    --    img [ src (urlPrefix ++ thumbnail.url) ] []
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selected", selectedUrl == thumbnail.url ) ]
        , onClick { description = "ClickedPhoto", data = thumbnail.url } ]
        []


-- update

update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data }
    else
        model

-- main
main =
    Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }

