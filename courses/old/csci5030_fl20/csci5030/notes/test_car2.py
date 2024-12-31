from car import car

def test_constructor():
	c1 = car( None, None )
	assert c1.distance == 0
