-- Tree is either Empty or a Node that has two subtrees
-- each of which could be null themselves.
data BinaryTree a = Empty | Node a (BinaryTree a) (BinaryTree a)
                    deriving (Show, Eq) 

instance Functor BinaryTree where
    -- This type definition is not necessary as the type definition
    -- is already defined in the Functor class.
    -- fmap :: (a -> b) -> BinaryTree a -> BinaryTree b
    fmap _ Empty = Empty
    fmap f (Node a leftTree rightTree) = Node (f a) (fmap f leftTree) (fmap f rightTree)

sampleTree = Node 1 (Node 2 (Node 3 Empty Empty)
                            (Node 3 Empty Empty))
                    (Node 4 Empty
                            (Node 5 (Node 6 Empty Empty)
                                    Empty))

binarySearchTree = Node 10 (Node 5 (Node 1 Empty Empty) 
                                   (Node 7 Empty Empty)) 
                           (Node 11 Empty Empty)

-- Tree may be empty so use Maybe.
root :: BinaryTree a -> Maybe a
root Empty = Nothing
root (Node a left right) = Just a

sumTree :: Num a => BinaryTree a -> a
sumTree Empty = 0
sumTree (Node a left right) = a + sumTree left + sumTree right

inOrderTraversal :: BinaryTree a -> [a]
inOrderTraversal Empty = []
inOrderTraversal (Node a left right) = inOrderTraversal left ++ [a] ++ inOrderTraversal right 

preOrderTraversal :: BinaryTree a -> [a]
preOrderTraversal Empty = []
preOrderTraversal (Node a left right) = [a] ++ preOrderTraversal left ++ preOrderTraversal right

postOrderTraversal :: BinaryTree a -> [a]
postOrderTraversal Empty = []
postOrderTraversal (Node a left right) = postOrderTraversal left ++ postOrderTraversal right ++ [a]

isBST :: BinaryTree Integer -> Bool
isBST = helper (-100) 100 
    where
        helper :: Integer -> Integer -> BinaryTree Integer -> Bool
        helper _ _ Empty = True 
        helper lowBound upBound (Node a left right) 
            | a < lowBound || (a > upBound) = False
            | otherwise = helper lowBound a left && helper a upBound right

-- Not a BST insert, inserts at most right position.
treeInsert :: a -> BinaryTree a -> BinaryTree a
treeInsert n Empty = Node n Empty Empty
treeInsert n (Node a left right) = Node a left (treeInsert n right) 

