{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Pred (
  Pred,
  cambiar, anyDib, allDib, orP, andP, falla
) where

import Dibujo (Dibujo,
  comp,
  figura,
  encimar,
  rotar,
  espejar,
  rot45,
  apilar,
  juntar,
  (^^^),
  (.-.),
  (///),
  r90,
  r180,
  r270,
  encimar4,
  cuarteto,
  ciclar,
  mapDib,
  change,
  foldDib)

type Pred a = a -> Bool


-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la figura básica indicada por el segundo argumento.

-- Or para unificar resultados de dos dibujos

-- Or para Encimar
orrE :: Bool -> Bool -> Bool
orrE dib1 dib2 = dib1 || dib2

-- Or para Apilar y Juntar
orrAJ :: Float -> Float -> Bool -> Bool -> Bool
orrAJ _ _ dib1 dib2 = dib1 || dib2

-- And para unificar resultados de dos dibujos

-- And para Encimar
andE :: Bool -> Bool -> Bool
andE dib1 dib2 = dib1 && dib2

-- And para Apilar y Juntar
andAJ :: Float -> Float -> Bool -> Bool -> Bool
andAJ _ _ dib1 dib2 = dib1 && dib2

-- cambiar (== Triangulo) (\x -> Rotar (Figura x)) Rotar x

cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar p g dib = foldDib (\x -> if p x then g x else figura x) rotar rot45 espejar apilar juntar encimar dib

-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib p dib = foldDib p id id id orrAJ orrAJ orrE dib

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib p dib = foldDib p id id id andAJ andAJ andE dib

-- Los dos predicados se cumplen para el elemento recibido.
andP :: Pred a -> Pred a -> Pred a
andP p g x = p x && g x 

-- Algún predicado se cumple para el elemento recibido.
orP :: Pred a -> Pred a -> Pred a
orP p g x = p x || g x 

falla = True