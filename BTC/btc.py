# author @qiya07
# date 2019 09 10

import requests
import json
import time
import re
URL = 'http://l10n-otc-api.dangpu.com/v1/otc/base/market/price'
while True:
    r = requests.get(URL)
    s = json.loads(r.content)
    print (time.strftime("%Y-%m-%d %H:%M:%S",time.localtime()),s['data'][1]['priceMap']['2'])
    time.sleep(60)