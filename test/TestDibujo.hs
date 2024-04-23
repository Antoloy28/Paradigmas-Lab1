module Main (main) where
import System.Exit ()
import Control.Monad()
import Dibujo
import Test.HUnit
import Control.Exception ()

testFigura :: Test
testFigura = 
    TestCase(assertEqual "Figura Triangulo" (figura "Triangulo") 
            (Figura "Triangulo"))

testRotar :: Test
testRotar = 
    TestCase(assertEqual "Rotar" (rotar (figura "Triangulo")) 
            (Rotar(Figura "Triangulo")))

testEspejar :: Test
testEspejar = 
    TestCase(assertEqual "Espejar" (espejar (figura "Triangulo")) 
            (Espejar(Figura "Triangulo")))

testApilar :: Test            
testApilar = 
    TestCase(assertEqual "Apilar" (apilar 1.0 1.0 (figura "Rectangulo") (figura "Triangulo")) 
            (Apilar 1.0 1.0 (Figura "Rectangulo") (Figura "Triangulo")))

testJuntar :: Test
testJuntar = 
    TestCase(assertEqual "Juntar" (juntar 2 2 (figura "Triangulo") 
            (figura "Rectangulo")) (Juntar 2 2 (Figura "Triangulo") (Figura "Rectangulo")))

--Lista para test
l3 :: [Int]
l3 = [1, 5, 4]

testComp0 :: Test
testComp0 =
    TestCase(assertEqual "(comp 0 l3) = id" l3 (comp 0 tail l3))

testComp1 :: Test
testComp1 =
    TestCase(assertEqual "(comp 1 l3) = l3" (tail l3) (comp 1 tail l3))

testRot45 :: Test
testRot45 =
    TestCase(assertEqual "(rot45 Rectangulo) = (Rot45 Rectangulo)" (rot45 (figura "Rectangulo")) (Rot45 (figura "Rectangulo")))

testR90 :: Test
testR90 =
    TestCase(assertEqual "(r90 Rectangulo) = (rotar Rectangulo)" (rotar (figura "Rectangulo")) (r90 (figura "Rectangulo")))

testR180 :: Test
testR180 = 
    TestCase(assertEqual "(r180 Rectangulo) = (rotar (rotar Rectangulo))" (comp 2 rotar (figura "Rectangulo")) (r180 (figura "Rectangulo")))

testR270 :: Test
testR270 =
    TestCase(assertEqual "(r270 Rectangulo) = (rotar (rotar (rotar Rectangulo)))" (comp 3 rotar (figura "Rectangulo")) (r270 (figura "Rectangulo"))) 



testEncimar :: Test
testEncimar =
    TestCase(assertEqual "(Encimar d (Encimar (rot45 d) (Encimar (r90 d) (Encimar (r180 d) (r270 d))) = Encimar4 d (rot45 d) (r90 d)"
        (Encimar (figura "Triantangulo") (Encimar (rot45 (figura "Triantangulo")) (Encimar (r90 (figura "Triantangulo")) (Encimar (r180 (figura "Triantangulo")) (r270 (figura "Triantangulo"))))))
        (encimar4 (figura "Triantangulo"))
        )

testMapdib :: Test
testMapdib = 
    TestCase(assertEqual "Cambio Rotar Triangulo por Rotar Cuadrado" 
        (Rotar (Figura "Cuadrado"))
        (mapDib (const "Cuadrado") (rotar (figura "Triangulo")))
        )

testChange :: Test
testChange = 
    TestCase(assertEqual "Cambio Rotar Triangulo por Rotar Rotar Cuadrado" 
        (Rotar (Rotar (Figura "Cuadrado")))
        (change (const (rotar (figura "Cuadrado"))) (rotar (figura "Triangulo")))
        )
        
testDibujo :: Test
testDibujo = 
    TestList [testFigura, testRotar, testEspejar, testApilar, testJuntar, testComp0,
     testComp1, testRot45, testR90, testR180, testR270, testEncimar, testChange, testMapdib]


main :: IO()
main = runTestTTAndExit testDibujo

