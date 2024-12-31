from car import car

class stubEngine():
	MPG = 30;

class stubFuelTank():
	size = 15;

def test_constructor():
	engine = stubEngine();
	fuel_tank = stubFuelTank();	

	c1 = car( engine, fuel_tank )
	assert c1.computeRange() == 450
