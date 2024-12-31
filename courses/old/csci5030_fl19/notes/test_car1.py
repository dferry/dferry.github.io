from car import car

class dummyEngine():
	pass;

class dummyFuelTank():
	pass;

def test_constructor():
	engine = dummyEngine();
	fuel_tank = dummyFuelTank();
	c1 = car( engine, fuel_tank )
	assert c1.distance == 0
