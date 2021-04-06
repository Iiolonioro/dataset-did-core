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

def key_to_json(data):
    if data is None or isinstance(data, (bool, int, str)):
        return data
    if isinstance(data, (tuple, frozenset)):
        return str(data)
    raise TypeError

def to_json(data):
    if data is None or isinstance(data, (bool, int, tuple, range, str, list)):
        return data
    if isinstance(data, (set, frozenset)):
        return sorted(data)
    if isinstance(data, dict):
        return {key_to_json(key): to_json(data[key]) for key in data}
    raise TypeError

def process_tag_as_sentence(file,tag):
    with open(file+".txt","w") as fp3:
        print(tag.text,file=fp3)

    with open(file+".md","w") as fp3:
        sentence = " ".join(html2text.html2text(tag.text).strip().split())
        print("S:"+sentence)
        print(sentence,file=fp3)
        tokens = nltk.word_tokenize(sentence)
        with open(file+"-tokens.json","w") as fp4:
            print(json.dumps(tokens,indent=2,sort_keys=True),file=fp4)

        all_counts = dict()
        for size in 2, 3, 4, 5:
            all_counts[size] = FreqDist(ngrams(tokens, size))
        with open(file+"-counts.json","w") as fp4:
            print(json.dumps(to_json(all_counts),indent=2,sort_keys=True),file=fp4)

        #entities = nltk.chunk.ne_chunk(tokens)
        #with open(file+"-entities.json","w") as fp4:
        #    print(json.dumps(entities,indent=2,sort_keys=True),file=fp4)

        #t = treebank.parsed_sents('wsj_0001.mrg')[0]
        #t.draw()

with open("index.html") as fp:
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
