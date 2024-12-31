from car import car
from unittest.mock import MagicMock

class stubEngine():
	MPG = 30;
	weight = 500;

class fakeFuelTank():
	current = 15;

	#Note, an actual gallon of gas weighs a little under six pounds, but
	# if I don't know that I can just guess it weighs exactly five pounds
	# and I can still validate the behavior of car.py
	def computeWeight( self ):
		return 20 + 5*self.current;

	#Note, I'm just guessing here. Maybe in a real fuel tank this function
	# would depend on temperature, time of day, phase of the moon, and
	# whether a Republican sits in the White House. Maybe not, but what do
	# I know? I'm just a programmer.
	def subtract( self, x ):
		self.current = self.current - x;

def test_constructor():
	engine = stubEngine();

	fuel_tank = fakeFuelTank();

	c1 = car( engine, fuel_tank )

	weight1 = c1.computeWeight();

	c1.drive(60);

	weight2 = c1.computeWeight();

	assert weight1 > weight2
