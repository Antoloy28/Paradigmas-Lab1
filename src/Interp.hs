module Interp
  ( interp,
    initial,
  )
where

import Dibujo
import FloatingPic
import Graphics.Gloss (Display (InWindow), color, display, makeColorI, pictures, translate, white, Picture)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial (Conf n dib intBas) size = display win white $ withGrid fig size
  where
    win = InWindow n (ceiling size, ceiling size) (0, 0)
    fig = interp intBas dib (0, 0) (size, 0) (0, size)
    desp = -(size / 2)
    withGrid p x = translate desp desp $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
    grey = makeColorI 100 100 100 100

-- Interpretación de (^^^)
ov :: Picture -> Picture -> Picture
ov f g d w h =  pictures[p, q]

r45 :: FloatingPic -> FloatingPic
r45 f d w h = f (d+(w+h)/2) ((w+h)/2) ((h-w)/2)

rot :: FloatingPic -> FloatingPic
rot f d w h = f (d + w) h (-w)

esp :: FloatingPic -> FloatingPic
esp f d w h = f (d+w) (-w) h

sup :: FloatingPic -> FloatingPic -> FloatingPic
sup f g d w h =  pictures[f d w h, g d w h]

jun :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
jun m n f g d w h = pictures[f d w' h, g (d+w') (r'*w) h]
                where
                    r' = n/(m+n)
                    r  = m/(m+n)
                    w' = r*w

api :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
api m n f g d w h = pictures[f (d+h') w (r*h), g d w h']
                where
                    r' = n/(m+n)
                    r  = m/(m+n)
                    h' = r'*w

-- (a -> FloatingPic) -> (Dibujo a -> Picture) = (a -> FloatingPic) -> Dibujo a -> Picture
-- Currificación P => (Q => R) = (P ^ Q => R) 

interp :: Output a -> Output (Dibujo a)
interp b dib = foldDib b rot t45 esp api jun sup dib 
