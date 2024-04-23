module Main (main) where
import System.Exit()
import Control.Monad()
import Pred (anyDib, allDib, cambiar, andP, orP)
import Test.HUnit
import Dibujo
import Data.Bool()

testCambiar :: Test
testCambiar = 
    TestCase(assertEqual "cambio Triangulo por Espejar Cuadrado" 
        (espejar (figura "Cuadrado"))
        (cambiar (== "Triangulo") (const (espejar (figura "Cuadrado"))) (figura "Triangulo"))
     )

testAnyDib0 :: Test
testAnyDib0 =
    TestCase(assertEqual "AnyDib (==Rectangulo) (Encimar (Figura Cuadrangulo) (Figura Rectangulo)) = True"
        (anyDib (== "Rectangulo") (encimar (figura "Cuadrangulo") (figura "Rectangulo")))
        True
    )

testAnyDib1 :: Test
testAnyDib1 =
    TestCase(assertEqual "anyDib (==Rectangulo) (Encimar (Figura Cuadrangulo) (Figura Rectangulo)) = True"
        (anyDib (== "Rectangulo") (encimar (figura "Cuadrangulo") (encimar (figura "Cuadrangulo10") (figura "Triangulo"))))
        False
    )

testAllDib0 :: Test
testAllDib0 =
    TestCase(assertEqual "AllDib (==Circucuadratangulo) (Encimar Circucuadratangulo (Encimar Circucuadratangulo Triangulo)) = False"
        (allDib (=="Circucuadratangulo") (encimar (figura "Circucuadratangulo") (encimar (figura "Circucuadratangulo") (figura "Triangulo"))))
        False
    )

testAllDib1 :: Test
testAllDib1 =
    TestCase(assertEqual "AllDib (==Cuadratangulocircutangulo) (Encimar Cuadratangulocircutangulo Cuadratangulocircutangulo) = True"
        (allDib (=="Cuadratangulocircutangulo") (encimar (figura "Cuadratangulocircutangulo") (figura "Cuadratangulocircutangulo")))
        True
    )

testAndP :: Test
testAndP =
    TestCase(assertEqual "Ambos predicados se cumplen"
        (andP (== figura "1") (/= figura "10") (figura "1"))
        True
    )

testOrP :: Test
testOrP =
    TestCase(assertEqual "Por lo menos un predicado se cumple"
        (orP (/= figura "1") (/= figura "10") (figura "1"))
        True
    )


testPred :: Test
testPred = 
    TestList [testCambiar, testAnyDib0, testAnyDib1, testAllDib0, testAllDib1, testAndP, testOrP]

main :: IO()
main = runTestTTAndExit testPred