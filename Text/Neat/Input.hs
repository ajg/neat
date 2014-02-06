-- Copyright 2014 Alvaro J. Genial [http://alva.ro]; see LICENSE file for more.

module Text.Neat.Input where

import Data.List (stripPrefix)

split :: Eq a => [a] -> [a] -> [[a]]
split [] l = fmap return l
split _ [] = [] : []
split d  l = case stripPrefix d l of
               Just rest -> [] : split d rest
               Nothing   -> let (x:xs) = l
                             in case split d xs of
                               []     -> [x:xs]
                               (y:ys) -> (x:y):ys
