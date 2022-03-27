module VDPSupport.Pages.OperationsPage.Common where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Data.Array (cons)
import VDPSupport.Pages.OperationsPage.Domain (ButtonClickAction(..), LegendItem, LegendItemArray)
import VDPSupport.Pages.OperationsPage.Styles (iconStyle, legendItemWidgetStyle, legendWidgetStyle, serviceStatusWidgetStyle, tableStyle)

legendWidget :: forall a. String -> LegendItemArray -> Widget HTML a
legendWidget legendTitle legendItems =
  D.fieldset [ legendWidgetStyle ]
    (cons legendTitleWidget legendWidgetContent)
  where
  legendTitleWidget = D.legend' [ D.text legendTitle ]

  legendWidgetContent = map legendItemWidget legendItems

  legendItemWidget :: forall b. LegendItem -> Widget HTML b
  legendItemWidget legendItem =
    D.div [ legendItemWidgetStyle ]
      [ legendItem.widget
      , D.label' [ D.text legendItem.label ]
      ]

tableWidget :: forall a. Widget HTML a -> Array (Widget HTML a) -> Widget HTML a
tableWidget tableHeadingsWidget tableRowItems = D.table [ tableStyle ] [ D.tbody' $ cons tableHeadingsWidget tableRowItems ]

serviceStatusWidget :: forall a. String -> Widget HTML a
serviceStatusWidget color = D.span [ serviceStatusWidgetStyle color ] []

refreshIconWidget :: String -> Widget HTML ButtonClickAction
refreshIconWidget size = iconWidget "fa fa-refresh" size (P.onClick $> Refresh)

loadingIconWidget :: forall a. String -> Widget HTML a
loadingIconWidget size = iconWidget "fa fa-refresh fa-spin" size P.emptyProp

-- Helper widgets
iconWidget :: forall a. String -> String -> P.ReactProps a -> Widget HTML a
iconWidget iconClass size prop =
  D.i
    [ P.className iconClass
    , iconStyle size
    , prop
    ]
    []
