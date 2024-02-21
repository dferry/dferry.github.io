module Expression
( size
, eval
) where

data Expr = Val Int
          | Add Expr Expr
          | Mul Expr Expr
	deriving Show

-- a simple size function, to count the number of values in there
size          :: Expr -> Int
size (Val n)   = 1
size (Add x y) = size x + size y
size (Mul x y) = size x + size y 


-- define eval recursively, adding appropriate operators
eval          :: Expr -> Int
eval (Val n)   = n
eval (Add x y) = eval x + eval y
eval (Mul x y) = eval x * eval y

