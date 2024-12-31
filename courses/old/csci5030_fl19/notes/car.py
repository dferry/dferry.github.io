
class car:

	def __init__( self, engine, fuel_tank ):
		self.engine = engine;
		self.fuel_tank = fuel_tank;
		self.distance = 0;

	#Range is gallons * miles per gallon
	def computeRange( self ):
		return self.fuel_tank.size * self.engine.MPG;


	def fillGasTank( self ):
		self.fuel_tank.refill();

	#Gallons used is miles / MPG
	def drive( self, miles ):
		gallons_gas_needed = miles / self.engine.MPG;

		if gallons_gas_needed < self.fuel_tank.current:
			self.fuel_tank.subtract( gallons_gas_needed );
			self.distance = self.distance + miles;
		else:
			raise ValueError("Car does not have enough gas!");

	#Units in pounds
	def computeWeight():
		return 1500 + self.engine.weight + self.fuel_tank.computeWeight(); 


