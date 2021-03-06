module Dialog.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (label, textarea)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


type Classes
    = Modal
    | ModalHeader
    | ModalBody
    | ModalFooter
    | ModalHidden
    | InputGroup
    | Input
    | Default
    | ConfirmButton
    | CancelButton
    | Spinner
    | Mask
    | ModalWrapper
    | Hidden


css =
    (stylesheet << namespace "")
        [ class Modal
            [ position absolute
            , width <| px 500
            , alignSelf center
            , backgroundColor <| hex "282828"
            , color <| hex "FFF"
            , height <| px 330
            , property "top" "calc(50% - 330px)"
            , zIndex <| int 9999
            , children
                [ class ModalHeader
                    [ backgroundColor <| hex "333"
                    , color <| hex "FFF"
                    , height <| px 40
                    , displayFlex
                    , alignItems center
                    , justifyContent center
                    ]
                , class ModalBody
                    [ padding <| px 10
                    ]
                , class ModalFooter
                    [ displayFlex
                    , justifyContent spaceAround
                    , padding2 zero (px 130)
                    ]
                ]
            , withClass ModalHidden
                [ display none
                ]
            ]
        , class InputGroup
            [ displayFlex
            , flexDirection column
            , margin2 (px 10) zero
            , children
                [ label
                    [ paddingBottom <| px 5
                    , fontSize <| pt 9
                    , color <| hex "b5b5b5"
                    ]
                ]
            ]
        , class Input
            [ height <| px 30
            , outline none
            , fontSize <| px 13
            , padding <| px 5
            ]
        , textarea
            [ outline none
            , resize none
            , fontSize <| px 13
            , padding <| px 5
            ]
        , each [ class CancelButton, class ConfirmButton ]
            [ height <| px 30
            , border3 (px 1) solid (hex "cacaca")
            , borderRadius <| px 30
            , width <| px 110
            , backgroundColor <| hex "1c1c1c"
            , color <| hex "FFF"
            , textTransform uppercase
            , fontSize <| pt 9.5
            , outline none
            ]
        , class ConfirmButton
            [ backgroundColor <| hex "1db954" ]
        , class Spinner
            [ width <| px 70
            , position absolute
            , property "top" "calc(50% - 35px)"
            , property "left" "calc(50% - 35px)"
            ]
        , class ModalWrapper
            [ position absolute
            , width <| pct 100
            , height <| pct 100
            , displayFlex
            , flexDirection column
            ]
        , class Mask
            [ position absolute
            , width <| pct 100
            , height <| pct 100
            , flexDirection column
            , backgroundColor <| rgba 0 0 0 0.5
            , zIndex <| int 1
            ]
        , class Hidden
            [ display none
            ]
        ]
