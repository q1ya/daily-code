import requests
import base64
import re
import sys
from bs4 import BeautifulSoup
import lxml

argc = len(sys.argv)
s = sys.argv[1]
print('[*]双引号用\，比如app=\\"apache\\"')
print('[*]',s)
bs = str(base64.b64encode(s.encode("utf-8")),"utf-8")
#有key再用这段
#email = ''
#apikey = ''
#r = requests.session().get('https://fofa.so/api/v1/search/all?email='+email+'&key='+apikey+'&qbase64='+bs)
def search_fofa():
    r = requests.session().get('https://fofa.so/result?qbase64='+bs)
    soup = BeautifulSoup(r.text,'lxml')
    r1 = str(soup.find_all(href=re.compile("javascript:view")))
    p = re.compile(r'[(][\'](.*?)[\'][)]', re.S)
    r2 = p.findall(r1)
    for i in r2:
        print(i)
        
search_fofa()

