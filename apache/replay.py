#!/usr/bin/python2
import os

import sys
sys.path.insert(0, "/api/lib/")
import Event
import traceback

print("Content-type:text/html\n\n")
if 'HTTP_X_CONTENT_FIELD_WAF' in os.environ and len(os.environ["HTTP_X_CONTENT_FIELD_WAF"]) > 0:
	try:
		content = os.environ["HTTP_X_CONTENT_FIELD_WAF"]
		print(Event.decrypt(content))
	except:
		print(traceback.format_exc())
else:
	print "<html><body>Index</body></html>"