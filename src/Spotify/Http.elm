module Spotify.Http exposing (..)

import Base64
import Http exposing (Header, Request, emptyBody, expectJson, header, jsonBody, request)
import HttpBuilder exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode
import Models exposing (SpotifyConfig)


resolveEncode : String -> String
resolveEncode string =
    case Base64.encode string of
        Ok s ->
            s

        Err err ->
            ""


defaultHeaders : String -> Header
defaultHeaders authToken =
    header "Authorization" ("Bearer " ++ authToken)


get : String -> Decode.Decoder a -> String -> Request a
get url decoder authToken =
    HttpBuilder.get url
        |> withHeader "Authorization" ("Bearer " ++ authToken)
        |> withExpect (expectJson decoder)
        |> toRequest


post : String -> Encode.Value -> Decode.Decoder a -> String -> Request a
post url body decoder authToken =
    HttpBuilder.post url
        |> withHeader "Authorization" ("Bearer " ++ authToken)
        |> withJsonBody body
        |> withExpect (expectJson decoder)
        |> toRequest
