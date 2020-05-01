module PhotoGroove exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (Html, button, div, h1, h3, img, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



--model


type ThumbnailSize
    = Small
    | Medium
    | Large



--type alias Msg =
--    { description : String
--    , data : String
--    }


type Msg
    = ClickedPhoto String
    | ClickedSize ThumbnailSize
    | ClickedSurpriseMe
    | Checked ThumbnailSize


type alias Photo =
    { url : String }


type alias Model =
    { photos : List Photo
    , selectedUrl : String
    , choosenSize : ThumbnailSize
    }


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    , choosenSize = Large
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos



-- view


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , button
            [ onClick ClickedSurpriseMe ]
            [ text "Surprise Me!" ]
        , h3 [] [ text "Thumbnail Size: " ]
        , div [ id "choose-size" ]
            (List.map (viewSizeChooser model) [ Small, Medium, Large ])
        , div [ id "thumbnails", class (sizeToString model.choosenSize) ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
        , img [ class "large", src (urlPrefix ++ "large/" ++ model.selectedUrl) ]
            []
        ]


viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedUrl thumbnail =
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selected", selectedUrl == thumbnail.url ) ]
        , onClick (ClickedPhoto thumbnail.url)
        ]
        []


viewSizeChooser : Model -> ThumbnailSize -> Html Msg
viewSizeChooser model thumbnailSize =
    label []
        [ input
            [ type_ "radio"
            , name "size"
            , onCheck (\booleanValue -> if booleanValue then Checked thumbnailSize else Checked model.choosenSize)
            --, onClick (ClickedSize thumbnailSize)
            , checked (if model.choosenSize == thumbnailSize then True else False)
            ]
            []
        , text (sizeToString thumbnailSize)
        ]

sizeToString : ThumbnailSize -> String
sizeToString size =
    case size of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"



-- update


getPhotoUrl : Int -> String
getPhotoUrl index =
    case Array.get index photoArray of
        Just photo ->
            photo.url

        Nothing ->
            ""


update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickedPhoto url ->
            { model | selectedUrl = url }

        ClickedSize size ->
            { model | choosenSize = size }

        ClickedSurpriseMe ->
            { model | selectedUrl = "2.jpeg" }

        Checked size ->
            { model | choosenSize = size }



--if msg.description == "ClickedPhoto" then
--    { model | selectedUrl = msg.data }
--
--else if msg.description == "ClickedSurpriseMe" then
--    { model | selectedUrl = "2.jpeg" }
--
--else
--    model
-- main


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
