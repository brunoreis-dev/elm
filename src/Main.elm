module Main exposing (..)
import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

type alias Model = Int

type Msg
  = Increment
  | Decrement
  | DivideByTwo

main : Program () Model Msg -- Signature (Type definition)
main = 
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions 
    } -- Implemantation
    
init : () -> (Model, Cmd Msg) -- Signature
init _ = 
  (0, Cmd.none) -- Implemantation

flip : (a -> b -> c) -> b -> a -> c
flip f b a =
  f a b

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of 
    Increment ->
      (model + 1, Cmd.none)

    Decrement ->
      (model - 1, Cmd.none)

    DivideByTwo ->
      if model > 1 then
      model
        |> toFloat
        |> flip (/) 2
        |> round
        |> flip Tuple.pair Cmd.none
      else
        (model, Cmd.none)
  
subscriptions : Model -> Sub Msg
subscriptions _ = 
  Sub.none

view : Model -> Html Msg
view model = 
  div []
    [ button [ onClick Decrement ] [ text "Decrement" ]
    , div [] [text (String.fromInt model)]
    , button [ onClick Increment ] [ text "Increment" ]
    , div [] [button [ onClick DivideByTwo ] [ text "Divide by two" ]]
    ]
