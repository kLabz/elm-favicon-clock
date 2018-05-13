port module FaviconClock exposing (..)

import Html exposing (Html, programWithFlags)
import Collage exposing (collage, text)
import Element exposing (toHtml)
import Color exposing (black)
import Text exposing (fromString, style, Style)
import Time as T exposing (Time)
import Date as D
import String exposing (padLeft)

-- CONSTANTS
canvasWidth : Int
canvasWidth = 16

canvasHeight : Int
canvasHeight = 16

fontSize : Float
fontSize = 14

textStyle : Style
textStyle = { typeface = ["monospace"]
            , height = Just fontSize
            , color = Color.rgb 233 234 235
            , bold = False
            , italic = False
            , line = Nothing
            }

-- PORTS
port updateFavicon : Int -> Cmd msg

-- UTILITY
fromTimeToHour : Time -> Int
fromTimeToHour = D.fromTime >> D.hour

fromTimeToMinute : Time -> Int
fromTimeToMinute = D.fromTime >> D.minute

fromTimeTo : String -> Time -> Int
fromTimeTo cltype =
  case cltype of
    "min"  -> fromTimeToMinute
    "hour" -> fromTimeToHour
    _      -> fromTimeToMinute

-- FLAG
type alias Flag = Model

-- MODEL
type alias Model =
  { cltype : String
  , time : Time
  }

-- MESSAGE
type Msg = Tick Time

-- INIT
init : Flag -> (Model, Cmd Msg)
init flag = (flag, Cmd.none)

-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      Tick time ->
        { model | time = time } ! [ fromTimeTo model.cltype time |> updateFavicon ]

-- VIEW
view : Model -> Html Msg
view model =
      collage canvasWidth canvasHeight [
                                        Collage.square 16
                                            |> Collage.filled (Color.rgb 42 48 59)
                                        , fromTimeTo model.cltype model.time
                                           |> toString
                                           |> padLeft 2 '0'
                                           |> fromString
                                           |> style textStyle
                                           |> text
                                       ]
        |> toHtml

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  T.every T.second Tick

-- MAIN
main : Program Flag Model Msg
main =
  programWithFlags
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }
