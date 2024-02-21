data Tree a = EmptyTree 
	| Node a (Tree a) (Tree a) 
		deriving (Show,Read,Eq) 

-- add functor declaration here

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

findInTree :: (Ord a) => a -> Tree a -> Bool
findInTree x EmptyTree = False
findInTree x (Node y left right)
	| x == y = True
	| x < y = findInTree x left
	| x > y = findInTree x right

-- put treeInsert here
