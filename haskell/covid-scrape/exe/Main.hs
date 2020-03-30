{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE NumericUnderscores #-}

module Main where

------------------------------------------------------------------------------
import Data.Time
import Options.Applicative
------------------------------------------------------------------------------
import Covid19
import Covid19.Utah
------------------------------------------------------------------------------


main :: IO ()
main = do
    now <- getCurrentTime
    let env = Env now
    c <- execParser opts
    case c of
      JHU -> runScraper env
      Utah -> scrapeUtah
  where
    opts = info (commands <**> helper)
      (fullDesc <> header "COVID-19 data scraping tools")

data Command = JHU | Utah

commands :: Parser Command
commands = hsubparser
  (  command "jhu" (info (pure JHU)
       (progDesc "Johns Hopkins dataset"))
  <> command "utah" (info (pure Utah)
       (progDesc "Utah cases"))
  )
