#!python3
import re
import requests
import csv
from bs4 import BeautifulSoup as bs4

url = 'https://www.win7dll.info/user32_dll.html'

def get_bs(u):
    req = requests.get(url, headers = {'user-agent': 'Mozilla/5.0'})
    bs = bs4(req.text, 'html.parser')
    return bs

bs = get_bs(url)
Id = 0

cols = []
for i in bs.find_all('table')[19]:
    td = i.find('td')
    cols.append(td.text)
    
cols = [i.replace("\r","").split('\n') for i in cols]
newCols = []
for i in cols:
    for j in i:
        if j != '':
            newCols.append(j)

count = 0
for i in newCols:
    count+=1
    if(i[-1]=='A'):
        newCols.insert(count, i[0:len(i)-1])

num_lines = sum(1 for line in open('C:/API index DB/API index.csv'))
#print(num_lines)

with open('C:/API index DB/API index.csv', 'a+', newline='') as f:
    csvwriter = csv.writer(f)
    Id = num_lines
    for i in newCols:
        #print(i)
        Name = i
        Id += 1
        csvwriter.writerow([Id, Name])
