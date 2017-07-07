#!/usr/bin/env python
# Monte Carlo pi calculator
# Inspired by: http://glowingpython.blogspot.co.il/2012/01/monte-carlo-estimate-for-pi-with-numpy.html

from numpy import random, pi
import sys

# scattering n points over the unit square
n = 10**5
if len(sys.argv) > 1:
    n = 10**int(sys.argv[1])

# counting the points inside the unit circle
inside = 0

print 'Pi calculator will run for %d iterations' % n

i = 0
while i < n:
    num = random.rand(2)
    if num[0]**2+num[1]**2 < 1:
        inside = inside + 1
    i += 1

# estimation of pi
print 'Estimated Pi: %0.16f' % (4 * float(inside) / n)
print 'Real pi:      %0.16f' % pi
