module Commands exposing (..)

import Http
import RemoteData
import Json.Decode as Decode

import Models exposing (Artist, searchArtistDecoder, topTracksDecoder, relatedArtistsDecoder, artistDecoder)
import Msgs exposing (SearchMsg, SidebarMsg, ExploreMsg)

fetchArtistUrl : String -> String
fetchArtistUrl artist =
  "https://api.spotify.com/v1/search?type=artist&limit=10&q=" ++ artist

fetchTopTracksUrl : String -> String
fetchTopTracksUrl artistId =
  "https://api.spotify.com/v1/artists/" ++ artistId ++ "/top-tracks?country=US"

fetchRelatedArtistsUrl : String -> String
fetchRelatedArtistsUrl artistId =
  "https://api.spotify.com/v1/artists/" ++ artistId ++ "/related-artists"

fetchArtistByIdUrl : String -> String
fetchArtistByIdUrl artistId =
  "https://api.spotify.com/v1/artists/" ++ artistId

fetchArtist : String -> Cmd SearchMsg
fetchArtist name =
  Http.get (fetchArtistUrl name) searchArtistDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.SearchArtistSuccess

fetchTopTracks : String -> Cmd SidebarMsg
fetchTopTracks artistId =
  Http.get (fetchTopTracksUrl artistId) topTracksDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.TopTracksSuccess

fetchRelatedArtists : String -> Cmd ExploreMsg
fetchRelatedArtists artistId =
  Http.get (fetchRelatedArtistsUrl artistId) relatedArtistsDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.RelatedArtistsSuccess

fetchArtistById : String -> Cmd ExploreMsg
fetchArtistById artistId =
  Http.get (fetchArtistByIdUrl artistId) artistDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.ArtistByIdSuccess
