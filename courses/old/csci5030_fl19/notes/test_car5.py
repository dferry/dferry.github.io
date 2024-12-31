from car import car
from unittest.mock import MagicMock

class stubEngine():
	MPG = 30;

class spyFuelTank():
	current = 15;
	def __init__( self ):
		self.subtract = MagicMock();


def test_constructor():
	engine = stubEngine();

	fuel_tank = spyFuelTank();

	c1 = car( engine, fuel_tank )

	c1.drive(60);

	fuel_tank.subtract.assert_called_with(2);
