import sys
import os
import json
import yaml
jekylldir=sys.argv[1]
print("JEKYLL:"+jekylldir)

by_title={}
by_count={}

def integrate_title(title,hash,mapping):
    defn=by_title.get(title,{})
    mappings = defn.get('mappings',{})
    instances = mappings.get(hash,[])
    instances.append(mapping)
    mappings[hash]=instances
    defn['mappings'] = mappings
    by_title[title]=defn
    defn['count']=len(instances)

def integrate(hash,mapping,descriptor):
    #major,minor,term,title,txt = mapping
    major=mapping['major']
    minor=mapping['minor']
    term=mapping['term']
    title=mapping['title']
    txt=mapping['txt']
    print("Values:",major,minor,term,title)
    integrate_title(title,hash,mapping)
    #print("Descriptor",descriptor)

for info in os.scandir(jekylldir+"/hashes"):
    with open(info) as fp:
        descriptor=json.load(fp)
        hashes=descriptor['hash']
        title=descriptor['title']
        for hash, mapping in hashes.items():
            integrate(hash,mapping,descriptor)

for title,mapping in by_title.items():
    m = by_count.get(mapping['count'],{})
    m[title] = mapping
    by_count[mapping['count']]=m

with open(jekylldir+"/sectiontitles.yml","w") as fp:
    print(yaml.dump(by_title),file=fp)

with open(jekylldir+"/mappingcounts.yml","w") as fp:
    print(yaml.dump(by_count),file=fp)
