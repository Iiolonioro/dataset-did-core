#!/usr/bin/python3
import spacy
import json
import sys

# Load English tokenizer, tagger, parser and NER
nlp = spacy.load("en_core_web_sm")

# Process whole documents
#file = "../markdown/index/index-2017-11-05T11:27-2383dec883e57a97709fcfeb0190546b7e1d5260.md"
file = sys.argv[1]
with open(file, 'r') as file:
  text = file.read()
doc = nlp(text)

# Analyze syntax
#print("Noun phrases:", [chunk.text for chunk in doc.noun_chunks])
#print("Verbs:", [token.lemma_ for token in doc if token.pos_ == "VERB"])

# Find named entities, phrases and concepts
semantics=dict()
types=dict()
for entity in doc.ents:
    name = entity.text
    type = entity.label_
    if not type in types:
        types[type]=[]
    map={
        'label':entity.text,
        'start':entity.start,
        'end':entity.end
        }
    types[entity.label_].append(map)

    if not name in semantics:
        semantics[name]=[]
    map={
        'type':entity.label_,
        'start':entity.start,
        'end':entity.end
        }
    semantics[name].append(map)

nouns=dict()
for chunk in doc.noun_chunks:
    base=chunk.text.strip()
    if not base in nouns:
        nouns[base]=[]
    nouns[base].append({
        'type':chunk.label_,
        'start':chunk.start,
        'end':chunk.end
        })

verbs=dict()
for chunk in [token.lemma_ for token in doc if token.pos_ == "VERB"]:
    base=chunk
    if not base in verbs:
        verbs[base]=0
    verbs[base]=verbs[base]+1

result={
	'nouns':nouns,
	'verbs':verbs,
	'terms':semantics,
	'types':types
	}
print(json.dumps(result,indent=2,sort_keys=True))

