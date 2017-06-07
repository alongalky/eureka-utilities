#!/usr/bin/env python
# Monte Carlo pi calculator
# Inspired by: http://glowingpython.blogspot.co.il/2012/01/monte-carlo-estimate-for-pi-with-numpy.html

from numpy import random, pi

# scattering n points over the unit square
n = 10**7
p = random.rand(n,2)

# counting the points inside the unit circle
idx = p[:,0]**2+p[:,1]**2 < 1

# estimation of pi
print 'Pi calculator will run for %d iterations' % n
print 'Estimated Pi: %0.16f' % (sum(idx).astype('double')/n*4)
print 'Real pi:      %0.16f' % pi
