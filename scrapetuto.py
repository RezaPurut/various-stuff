#!python3
import re
import requests
from bs4 import BeautifulSoup as bs4

url = 'http://www.imdb.com/chart/moviemeter?ref_=nv_mv_mpm_8'

def get_bs(u):
    req = requests.get(url, headers = {'user-agent': 'Mozilla/5.0'})
    bs = bs4(req.text, 'html.parser')
    return bs

bs = get_bs(url)
for i in bs.find_all('td', class_='titleColumn'):
    if i.a:
        print(i.a.text)

