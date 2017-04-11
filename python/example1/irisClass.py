__metaclass__ = type # Make sure we get new style classes

class Iris:
	mood = "bad hair day"
	def __init__(self,sleepHours):
		if sleepHours<8:
			self.mood = "bad mood"
		else:
			self.mood = "an okay mood"

	def greetings(self):
		print "Whats up? Today I am in a "+ self.mood
