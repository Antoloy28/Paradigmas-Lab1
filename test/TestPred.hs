module Main (main) where
import System.Exit (exitFailure)
import Control.Monad (when)
import Pred (anyDib, allDib, falla, cambiar)
import Test.HUnit
import Dibujo
import Dibujo (figura)

testCambiar :: Test
testCambiar = 
    TestCase(assertEqual "Triangulo = Espejar Triangulo" 
     (espejar (figura "Triangulo"))
     (cambiar (== "Triangulo") (const (espejar (figura "Triangulo"))) (figura "Triangulo"))
     )

testPred :: Test
testPred = 
    TestList [testCambiar]

main = runTestTT testPred