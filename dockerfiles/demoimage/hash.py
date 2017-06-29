#!/usr/bin/env python
# MD5 Hash cracker

import hashlib
import sys

if __name__ == "__main__":
  maxDigits = int(sys.argv[1])
  maxNumber = 10 ** maxDigits
  targetHash = sys.argv[2]
  success = False

  i = 0
  while i <= maxNumber:
    iHash = hashlib.md5(str(i)).hexdigest()
    if targetHash == iHash:
      print "Found the hash! It's: {}".format(i)
      success = True
      break
    i = i + 1
  
  if not success:
    print "Failed! Hash not found in the range 0,{}".format(maxNumber)
    
