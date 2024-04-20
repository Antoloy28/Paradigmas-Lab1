module Dibujo (
  Dibujo(..), 
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
  foldDib
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
(.-.) = Apilar 1 1

(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = Juntar 1 1

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
cuarteto a b c d = Apilar 1 1 (Juntar 1 1 a b) (Juntar 1 1 c d)

-- un cuarteto donde se repite la imagen, rotada (¡No confundir con encimar4!)
ciclar :: Dibujo a -> Dibujo a
ciclar a = cuarteto a (r90 a) (r180 a) (r270 a)

-- map para nuestro lenguaje
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Figura x) = Figura (f x)
mapDib f (Rotar a) = Rotar (mapDib f a)
mapDib f (Espejar a) = Espejar (mapDib f a)
mapDib f (Rot45 a) = Rot45 (mapDib f a)
mapDib f (Encimar a b) = Encimar (mapDib f a) (mapDib f b)
mapDib f (Apilar n m a b) = Apilar n m (mapDib f a) (mapDib f b)
mapDib f (Juntar n m a b) = Juntar n m (mapDib f a) (mapDib f b)

-- verificar que las operaciones satisfagan
-- 1. map figura = id
-- 2. map (g . f) = mapDib g . mapDib f

-- Cambiar todas las básicas de acuerdo a la función.
change :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
change f (Figura x) = f x
change f (Rotar a) = Rotar (change f a)
change f (Espejar a) = Espejar (change f a)
change f (Rot45 a) = Rot45 (change f a)
change f (Encimar a b) = Encimar (change f a) (change f b)
change f (Apilar n m a b) = Apilar n m (change f a) (change f b)
change f (Juntar n m a b) = Juntar n m (change f a) (change f b)

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

-- f fRot fRot45 fEs fAp fJu fEn = f g h i j k l
foldDib f _ _ _ _ _ _ (Figura fig) = f fig
foldDib f g h i j k l (Rotar dib) = g (foldDib f g h i j k l dib)
foldDib f g h i j k l (Rot45 dib) = h (foldDib f g h i j k l dib)
foldDib f g h i j k l (Espejar dib) = i (foldDib f g h i j k l dib)
foldDib f g h i j k l (Apilar n m dib1 dib2) = j n m (foldDib f g h i j k l dib1) (foldDib f g h i j k l dib2)
foldDib f g h i j k l (Juntar n m dib1 dib2) = k n m (foldDib f g h i j k l dib1) (foldDib f g h i j k l dib2)
foldDib f g h i j k l (Encimar dib1 dib2) = l (foldDib f g h i j k l dib1) (foldDib f g h i j k l dib2)