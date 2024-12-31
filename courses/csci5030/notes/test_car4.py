from car import car
from unittest.mock import MagicMock

class dummyEngine():
	pass;

class spyFuelTank():
	def __init__( self ):
		self.refill = MagicMock();

def test_constructor():
	engine = dummyEngine();

	fuel_tank = spyFuelTank();

	c1 = car( engine, fuel_tank )
	#c1.fillGasTank();

	fuel_tank.refill.assert_called()
