%Cell Arrays
%David and class
% 4/4/2020

%what's the problem?
%MATLAB is good at storing numeric data as arrays and matrices:

rand( 3, 5 )

%Where does this break down?

%names = [ 'Alice'; 'Bob'; 'Claire' ] %error - invalid dimensions
a = 'Alice'
b = 'Bob'

uint8( a )
uint8( b )

names = [ 'Alice '; 'Bob   '; 'Claire' ]

secondName = names( 2, : )

uint8( secondName )

names(2) %Semantically we'd really like this to be 'Bob'

%other funniness - we can take a column
thirdColumn = names( :, 3 )

%Probably biggest problem... what if we modify this data?

%Set the third row to Clarence

%names( 3, : ) = 'Clarence' %Error- Clarence is eight characters, the third row is six characters

%%

%Another shortcoming - not just text data, but also aggregate data

M = [ 50  'A';
      100 'B';
      150 'C']
  
  char( M)
  
  uint8(M)
  
%One possible solution:
nums = [ 50, 100, 150 ]
letters = [ 'A', 'B', 'C' ]

%Access together
secondNum = nums(2)
secondLetter = letters(2)

shuffle = @(v) v(randperm(length(v)))

shuffle( nums )
shuffle( letters )

%shuffle( M )

%%

%The better way: cell arrays

%Declare a cell aray with curly braces {}

%Recall declare a vector with  []
v = [ 1 2 9 10 ]

names = { 'Alice', 'Bob', 'Claire' }

%Give me the second name

names(2)

names = { 'Alice' 'Bob'   'Claire';
          'David' 'Erica' 'Fred' }
      
names(2,3)

%Aggregate data with cells:
names = { 'Alice' 'Bob' 'Claire';
          50      100   150 }
     
names( :, 3 )

%Unfortunately, cell arrays can be a little harder to work with
name = names(1,2)
%name(2) %We would hope this is 'o' - but error
nameAsChars = char( name )
nameAsChars (2) %Should be 'o'

%Problem exists the other way too
%names(1,3) = 'Clarence' %Error, conversion to cell is not possible
newName = 'Clarence'
nameAsCell = cellstr( newName )
names( 1,3 ) = nameAsCell




