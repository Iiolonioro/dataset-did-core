import sys
import os
import json

jekylldir=sys.argv[1]
sourcedir=sys.argv[2]+"/index"

print("SOURCDIR:"+sourcedir)

def load_file_text(file):
    try:
        with open(file) as f:
            return f.read()
    except Exception as E:
        print(E)
        return None

def load_file_json(file):
    try:
        text = load_file_text(file)
        if text:
            return json.loads(text)
        else:
            return {}
    except Exception as E:
        print(E)
        return None

def load_suite(file):
    return {
        "hash":load_file_text(file+".hash"),
        "html":load_file_text(file+".html"),
        "txt":load_file_text(file+".txt"),
        "markdown":load_file_text(file+".md"),
        "tokens":load_file_json(file+"-tokens.json"),
        "counts":load_file_json(file+"-counts.json"),
        "spacy":load_file_json(file+"-spacy.json")
    }

with open(os.path.join(sourcedir,"toc_index.json")) as fp:
    toc = json.load(fp)
    commit_data={
        "section":{
            "named":{
                "sotd":{},
                "abstract":{},
                "intro":{},
                "index":{},
                "toc":{},
                },
            "numbered":{}
            },
        "hash":{}
    }
    for t,title in toc:
        (major,minor) = t.split(".")
        base = os.path.join(sourcedir,t)
        suite = load_suite(base)
        suite['toc'] = t
        suite['title'] = title
        maj = commit_data['section']['numbered'].get(major,{})
        maj[minor]=suite
        commit_data['section']['numbered'][major]=maj
        commit_data['hash'][suite['hash']]=t
    with open(jekylldir+".json","w") as fp:
        json.dump(commit_data,fp,indent=2,sort_keys=True)
