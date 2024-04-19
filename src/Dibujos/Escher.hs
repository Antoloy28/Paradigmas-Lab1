module Dibujos.Escher (
    escher, eschConf
) where

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar, r90, r180, r270, cuarteto)
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture, blue, red, color, line, pictures, blank )


data Basica = Triangulo | Blank deriving (Show, Eq)

interpBasica :: Output Basica
interpBasica Triangulo d w h = line $ map (d V.+) [(0,0), w V.+ half h, h, (0,0)]
interpBasica Blank d w h = blank

type Escher = Basica

-- El dibujo u.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = encimar (encimar p2 (r90 p2)) (encimar (r180 p2) (r270 p2))
        where
            p2 = espejar (rot45 p)

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT p = encimar p (encimar p2 (r270 p2))
        where
            p2 = espejar (rot45 p)

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 1 p = cuarteto (figura Blank) (figura Blank) (figura Blank) (dibujoU p)
esquina 2 p = cuarteto (esquina 1 p) (lado 1 p) (r90 (lado 1 p)) (dibujoU p)
esquina n p = cuarteto (esquina (n-1) p) (lado n p) (r90 (lado n p)) (dibujoU p)

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 1 p = cuarteto (figura Blank) (figura Blank) (r90 (dibujoT p)) (dibujoT p)
lado 2 p = cuarteto (lado 1 p) (lado 1 p) (r90 (dibujoT p)) (dibujoT p)
lado n p = cuarteto (lado (n-1) p) (lado (n-1) p) (r90 (dibujoT p)) (dibujoT p)
  
-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = apilar 1 2 (juntar 1 2 p b_qr) (apilar 1 1 b_s_tu b_v_wx)
        where 
            b_qr = juntar 1 1 q r
            b_tu = juntar 1 1 t u 
            b_wx = juntar 1 1 w x
            b_s_tu = juntar 1 2 s b_tu
            b_v_wx = juntar 1 2 v b_wx

-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher n p = noneto esq lad (r270 esq) 
                    (r90 lad) (dibujoU (figura p)) (r270 lad)
                    (r90 esq) (r180 lad) (r180 esq) 
                where
                    esq = esquina n (figura p) 
                    lad = lado n (figura p)

testAllEsch :: Dibujo Basica
testAllEsch = escher 8 Triangulo

eschConf :: Conf
eschConf = Conf {
    name = "Escher"
    , pic = testAllEsch
    , bas = interpBasica
}
