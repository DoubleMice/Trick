import os
i=0
cmd = 'find / -name "*.py" -print 2>/dev/null'
for Files in os.popen(cmd).readlines():
	try:
		Files = Files[:-1]
		print "file:"+Files
		i+=1
		victim = open(Files,'r')
		fix = open(Files+"xx",'a+')
		while True:
			readvictim = victim.readline()
			if not readvictim :
				break
			if "#!x" not in readvictim:
				mycode=readvictim
				fix.write(mycode)
		victim.close()
		fix.flush()
		fix.close()
		os.remove(Files)
		os.rename(Files+"xx",Files)
	except :
		pass
print "total:"+str(i)
