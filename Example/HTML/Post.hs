{-# LANGUAGE FlexibleInstances, OverlappingInstances #-}

module Example.HTML.Post where

data Post = Post Author Subject [Paragraph]

type Author    = String
type Subject   = UserInput
type Paragraph = UserInput

newtype UserInput = UserInput String

instance Show String where
  show s = s

instance Show UserInput where
  show (UserInput s) = s -- TODO: Escape.

safe (UserInput s) = s
