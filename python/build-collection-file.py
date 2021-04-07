from bs4 import BeautifulSoup
import html2text
import nltk
nltk.download('punkt')
nltk.download('maxent_ne_chunker')
nltk.download('words')
nltk.download('treebank')
import json
from nltk.corpus import treebank
from nltk import ngrams, FreqDist

def load_file_text(file):
    with open(file) as f:
        return read(f)

def load_file_json(file):
    return json.parse(load_file_text(file))

section={
    "text":load_file_text(file+".txt"),
    "markdown":load_file_text(file+".md"),
    "tokens":load_file_json(file+"-tokens.json"),
    "counts":load_file_json(file+"-contes.json"),
    "sections":[],
    "hashs":{}
}

def load_quad(t):

with open("toc_index.json") as fp:
    toc = json.load(fp)
    for t in toc:
        section.sections.append(load_quad(t))

    soup = BeautifulSoup(fp, "html.parser")

    with open("abstract.html","w") as fp2:
        tag = soup.find(id="abstract")
        print(tag,file=fp2)
        process_tag_as_sentence("abstract",tag)

    with open("sotd.html","w") as fp2:
        tag = soup.find(id="sotd")
        print(tag,file=fp2)
        process_tag_as_sentence("sotd",tag)

    with open("toc.md","w") as fp2:
        level1_num=1
        level2_num=0
        for tag in soup.find_all("section"):
            found = tag.find('h1')
            if found:
                title=found.text
                level1_num = level1_num + 1
                level2_num = 0
            else:
                found = tag.find('h2')
                if found:
                    level2_num = level2_num + 1
                    title=found.text
                else:
                    level1_num = level1_num + 1
                    level2_num = 0
                    title = "untitled section"
            label = str(level1_num)+"."+str(level2_num)
            print(label,"\t",title,file = fp2)
            with open(label+".html","w") as fp3:
                print(tag.text,file=fp3)
            with open(label+".md","w") as fp3:
                print(html2text.html2text(tag.text),file=fp3)
            process_tag_as_sentence(label,tag)
