module BottomBar.View exposing (..)

import Html exposing (Html, div, text, span, img, i, input)
import Html.Attributes exposing (src, type_, step, value)
import Html.Events exposing (onClick, onInput)
import Html.CssHelpers
import RemoteData
import Css exposing (property)

import Models exposing (Model, Artist, SearchArtistData, Track)
import Msgs exposing (PlayerMsg)
import Helpers

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

styles : List Css.Mixin -> Html.Attribute msg
styles =
  Css.asPairs >> Html.Attributes.style

controlIcon : String -> Html PlayerMsg
controlIcon icon =
  div [ class [ CssClasses.ControlIcon ] ]
      [ i [ class [ CssClasses.Icon ], Html.Attributes.class ("fa fa-" ++ icon) ] [] ]

progressBar : Float -> (String -> PlayerMsg) -> Html PlayerMsg
progressBar progress msg =
  div [ class [ CssClasses.ProgressBar ] ]
      [ div
          [ class [ CssClasses.Progress ]
          , styles
              [ property "width" (toString (floor progress) ++ "%") ]
          ] []
      , input
          [ type_ "range"
          , class []
          , Html.Attributes.max "100"
          , Html.Attributes.min "0"
          , step "1"
          , onInput msg
          , value <| toString <| floor progress
      ]
          []
      ]

progress : Model -> Html PlayerMsg
progress model =
  div [ class [ CssClasses.ProgressGroup ] ]
      [ span [ class [ CssClasses.FontSmall ] ]
          [ text <| "00:" ++ (Helpers.paddValue model.audioStatus.currentTime) ]
      , progressBar (Helpers.getPct model.audioStatus.currentTime model.audioStatus.duration) Msgs.UpdateCurrentTime
      , span [ class [ CssClasses.FontSmall ] ]
          [ text <| "00:" ++ (Helpers.paddValue  model.audioStatus.duration) ]
      ]

musicInfo : Maybe Track -> Html PlayerMsg
musicInfo selectedTrack =
  let
    content =
      case selectedTrack of
        Just track ->
          [ img
              [ src <| Helpers.firstImageUrl track.album.images
              , class [ CssClasses.AlbumCover ]
              ] []
          , div [ class [ CssClasses.MusicInfo ] ]
              [ span [ class [ CssClasses.MusicTitle ] ]
                  [ text track.name ]
              , span [ class [ CssClasses.FontSmall ] ]
                  [ text <| Helpers.firstArtistName track.artists ]
              ]
          ]

        Nothing ->
          []
  in
    div [ class [ CssClasses.NowPlaying] ]
      content

soundControl : Model -> Html PlayerMsg
soundControl model =
  let
    icon =
      if model.audioStatus.volume > 0.6 then
        controlIcon "volume-up"
      else if model.audioStatus.volume > 0 then
        controlIcon "volume-down"
      else
        controlIcon "volume-off"
  in
    div [ class [ CssClasses.SoundControl ] ]
      [ div [ class [ CssClasses.ControlButtons ] ]
          [ icon ]
      , progressBar (model.audioStatus.volume * 100) Msgs.UpdateVolume ]


controls : Model -> Html PlayerMsg
controls model =
  let
    preview =
      case model.selectedTrack of
        Just track ->
          track.preview_url

        Nothing ->
          ""

    playOrPause =
      if model.isPlaying then
        div [ onClick Msgs.Pause ] [ controlIcon "pause" ]
      else
        div [ onClick (Msgs.Play preview) ] [ controlIcon "play" ]

  in
    div [ class [ CssClasses.Controls ] ]
        [ div [ class [ CssClasses.ControlButtons ] ]
            [ div [ onClick Msgs.Previous ] [ controlIcon "step-backward" ]
            , playOrPause
            , div [ onClick Msgs.Next ] [ controlIcon "step-forward" ]
            ]
        , progress model
        ]

maybeArtists : RemoteData.WebData SearchArtistData -> Html PlayerMsg
maybeArtists response =
  case response of
    RemoteData.NotAsked ->
      text "Not Asked"

    RemoteData.Loading ->
      text "Loading..."

    RemoteData.Success data ->
      text <| toString (data)

    RemoteData.Failure error ->
      text (toString "Error")


render : Model -> Html PlayerMsg
render model =
  div [ class [ CssClasses.BottomBar ] ]
      [ musicInfo model.selectedTrack
      , controls model
      , soundControl model
      ]
