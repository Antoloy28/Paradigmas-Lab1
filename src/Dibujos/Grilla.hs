module Dibujos.Grilla (
    grilla, corConf
) where

import Dibujo (Dibujo, figura, juntar, apilar, rot45, rotar, encimar, espejar)
import FloatingPic(Conf(..), Output, half, zero)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss ( Picture , blue, red, color, line, pictures, text )
import Graphics.Gloss.Data.Picture(translate , scale)
import Dibujos.Feo (testAll)

type Coordenada = (Int, Int)

interpCor :: Output Coordenada
interpCor (x, y) d w h = translate (fst d) (snd d) (text ( "(" ++ show x ++ "," ++ show y ++ ")" ))

row :: [Dibujo a] -> Dibujo a
row [] = error "row: no puede ser vacío"
row [d] = d
row (d:ds) = juntar (fromIntegral $ length ds) 1 d (row ds)

column :: [Dibujo a] -> Dibujo a
column [] = error "column: no puede ser vacío"
column [d] = d
column (d:ds) = apilar (fromIntegral $ length ds) 1 d (column ds)

grilla :: [[Dibujo a]] -> Dibujo a
grilla = column . map row

testAllCor :: Dibujo Coordenada
testAllCor = grilla [ [figura (0, 0), figura (0, 1), figura (0,2)],
                      [figura (1, 1), figura (1, 2), figura (1,3)]
                    ]


corConf :: Conf
corConf = Conf {
    name = "Grilla"
    , pic = testAllCor
    , bas = interpCor
}