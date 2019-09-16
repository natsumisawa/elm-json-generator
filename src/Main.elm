module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- ---------------------------
-- MODEL
-- ---------------------------


type alias Model =
    { form : Form
    , jsonText : String
    }


type alias Form =
    { text : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { form = Form "", jsonText = "" }, Cmd.none )



-- ---------------------------
-- UPDATE
-- ---------------------------


type Msg
    = Input String
    | Convert


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        { form } =
            model
    in
    case msg of
        Input input ->
            ( { model | form = { form | text = input } }, Cmd.none )

        Convert ->
            ( { model | jsonText = convert form }, Cmd.none )


convert : Form -> String
convert form =
    "Json.obj( " ++ form.text ++ " -> ??? )"



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Browser.Document Msg
view model =
    let
        { form, jsonText } =
            model
    in
    { title = "json convertor"
    , body =
        [ header [ class "site-header" ]
            [ h1 [] [ text "json convertor" ]
            ]
        , main_ []
            [ article []
                [ input [ onInput Input ] []
                , button [ onClick Convert ] [ text "converte" ]
                ]
            , article [] [ text jsonText ]
            ]
        ]
    }



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
