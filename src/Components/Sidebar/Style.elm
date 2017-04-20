module Components.Sidebar.Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

css =
  (stylesheet << namespace "")
  [ class CssClasses.Sidebar
      [ width <| px 200
      , height <| pct 100
      , transform <| translateX <| px 0
      , property "transition" "0.3s ease all"
      , displayFlex
      , flexDirection column
      , padding <| px 20

      , withClass CssClasses.SidebarActive
          [ transform <| translateX <| px -200 ]
      ]

  , class CssClasses.NavGroup
      [ padding2 (px 10) zero
      , borderBottom3 (px 1) solid (rgba 183 183 183 0.42)
      ]

  , class CssClasses.Logo
      [ color <| hex "FFF" ]
  ]
