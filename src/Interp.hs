module Interp
  ( interp,
    initial,
  )
where

import Dibujo
import FloatingPic
import Graphics.Gloss (Display (InWindow), color, display, makeColorI, pictures, translate, white, Picture)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss.Data.Vector (Vector, mulSV)


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
ov p q =  pictures [p, q]

r45 :: FloatingPic -> FloatingPic
r45 f d w h = f d_f w_f h_f
            where
              d_f = d V.+ mulSV 0.5 (w V.+ h)
              w_f = mulSV 0.5 (w V.+ h)
              h_f = mulSV 0.5 (h V.- w)
rot :: FloatingPic -> FloatingPic
rot f d w h = f d_f h h_f
            where
              d_f = d V.+ w
              h_f = mulSV (-1) w

esp :: FloatingPic -> FloatingPic
esp f d w = f d_f w_f
            where
              d_f = d V.+ w
              w_f = mulSV (-1) w

sup :: FloatingPic -> FloatingPic -> FloatingPic
sup f g d w h =  pictures [f d w h, g d w h]

jun :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
jun m n f g d w h = pictures [f d w' h, g d_g w_g h]
                where
                    r' = n/(m+n)
                    r  = m/(m+n)
                    w' = mulSV r w
                    w_g = mulSV r' w
                    d_g = d V.+ w'

api :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
api m n f g d w h = pictures [f d_f w h_f, g d w h']
                where
                    r' = n/(m+n)
                    r  = m/(m+n)
                    h' = mulSV r' w
                    h_f = mulSV r h
                    d_f = d V.+ h'

-- (a -> FloatingPic) -> (Dibujo a -> FloatingPic) -> Picture = (a -> FloatingPic) -> Dibujo a -> Picture
-- Currificación P => (Q => R) = (P ^ Q => R) 

interp :: Output a -> Output (Dibujo a)
interp b = foldDib b rot r45 esp api jun sup

