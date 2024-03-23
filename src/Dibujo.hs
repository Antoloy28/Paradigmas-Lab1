module Dibujo (
	Dibujo, 
	encimar, rotar, espejar, rot45, apilar, juntar 
    ) where


-- nuestro lenguaje 
data Dibujo a = Figura a
		| Rotar (Dibujo a) 
		| Espejar (Dibujo a) 
		| Rot45 (Dibujo a) 
		| Apilar (Float) (Float) (Dibujo a) (Dibujo a)
		| Juntar (Float) (Float) (Dibujo a) (Dibujo a)
		| Encimar (Dibujo a) (Dibujo a) 			deriving (Eq, Show)

-- combinadores
infixr 6 ^^^

infixr 7 .-.

infixr 8 ///

comp :: Int -> (a -> a) -> a -> a
comp 0 _ a = a
comp n f a = f (comp (n-1) f a)


-- Funciones constructoras
figura :: a -> Dibujo a
figura = Figura

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar = Encimar

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar = Apilar

juntar  :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar = Juntar

rot45 :: Dibujo a -> Dibujo a
rot45 = Rot45

rotar :: Dibujo a -> Dibujo a
rotar = Rotar


espejar :: Dibujo a -> Dibujo a
espejar = Espejar

(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = Encimar

(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) = Apilar

(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = Juntar

-- rotaciones
r90 :: Dibujo a -> Dibujo a
r90 = rotar

r180 :: Dibujo a -> Dibujo a
r180 = rotar . rotar

r270 :: Dibujo a -> Dibujo a
r270 = r180 . rotar

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 d = Encimar d (Encimar (rot45 d) (Encimar (r90 d) (Encimar (r180 d) (r270 d))))

-- cuatro figuras en un cuadrante.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto = undefined

-- un cuarteto donde se repite la imagen, rotada (¡No confundir con encimar4!)
ciclar :: Dibujo a -> Dibujo a
ciclar = undefined

-- map para nuestro lenguaje
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib = undefined
-- verificar que las operaciones satisfagan
-- 1. map figura = id
-- 2. map (g . f) = mapDib g . mapDib f

-- Cambiar todas las básicas de acuerdo a la función.
change :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
change = undefined

-- Principio de recursión para Dibujos.
foldDib ::
  (a -> b) ->
  (b -> b) ->
  (b -> b) ->
  (b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (b -> b -> b) ->
  Dibujo a ->
  b
foldDib = undefined