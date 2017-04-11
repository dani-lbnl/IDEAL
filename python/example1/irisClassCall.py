#!/usr/bin/bin Python2.7.11
import irisClass as ic
import sys

hoursOfSleep = sys.argv[1]
print 'Numbers of hour she slept=' + hoursOfSleep
today = ic.Iris(hoursOfSleep)
today.greetings()
