from bs4 import BeautifulSoup

with open("index.html") as fp:
    soup = BeautifulSoup(fp, "html.parser")
    header = None
    for tag in soup.find_all("section"):
        found = tag.find('h1')
        if found:
            level=1
            title=found.text
        else:
            found = tag.find('h2')
            if found:
                level=2
                title=found.text
            else:
                level=0
                if not header:
                    header = tag.text
        if level > 0:
            print(level,"\t",title)
    print(header)
