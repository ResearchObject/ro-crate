#!/usr/bin/env python3

#   Copyright 2019 The University of Manchester UK
#   Copyright 2019 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

"""
This script retrieves the schema.org properties to generate
the corresponding simplified @context for RO-Crate
adding our additional properties.

Run as:
./schema-context.py > ../docs/0.3-DRAFT/context.jsonld
""" 

import sys
import json
import requests
from collections import OrderedDict
import urllib.request


# Our own version
ROCRATE_VERSION="1.1-DRAFT"

# Update version from http://schema.org/docs/releases.html
SCHEMA_VERSION="8.0"

# Update from https://bioschemas.org/profiles/Workflow/
BIOSCHEMA_WORKFLOW_PROFILE = "https://bioschemas.org/profiles/Workflow/0.5-DRAFT-2020_xx_xx/"
BIOSCHEMA_WORKFLOW_NS = "https://bioschemas.org/Workflow"
BIOSCHEMA_FORMAL_PARAMETER_NS = "https://bioschemas.org/FormalParameter"


def main():
    url="http://schema.org/version/%s/schemaorgcontext.jsonld" % SCHEMA_VERSION
    with urllib.request.urlopen(url) as f:
      schema = json.load(f)

    schemakeys = list(schema["@context"].keys())
    schemakeys.sort() # they are usually sorted anyway
    j = OrderedDict()
    j["@id"] = "https://w3id.org/ro/crate/%s/context" % ROCRATE_VERSION
    j["name"] = "RO-Crate JSON-LD Context",
    j["version"] = ROCRATE_VERSION
    j["url"] = {"@id": "https://w3id.org/ro/crate/%s" % ROCRATE_VERSION}
    
    j["schemaVersion"] = {"@id": "http://schema.org/version/%s/" % SCHEMA_VERSION}
    j["isBasedOn"] = [
        {"@id": "http://schema.org/version/%s/" % SCHEMA_VERSION},
        {"@id": "https://pcdm.org/2016/04/18/models"},
        {"@id": BIOSCHEMA_WORKFLOW_PROFILE }
    ]
    j["license"] = {"@id": "https://creativecommons.org/publicdomain/zero/1.0/"}
    context = OrderedDict()
    j["@context"] = context
    for k in schemakeys:
      if ":" in k: # URL like https://www.w3.org/wiki/WebSchemas/SchemaDotOrgSources#TP
        continue
      if "@" in k: # @vocab?
        continue
      definition = schema["@context"][k]
      if not "@id" in definition or isinstance(definition, str):
          continue # bibo etc.
      context[k] = schema["@context"][k]["@id"].replace("schema:", "http://schema.org/")

    context.update(ADDITIONAL)
    json.dump(j, sys.stdout, ensure_ascii=False, indent=5) # indent4 to match existing!


# Ordered so we keep a somewhat ordered presentation in the JSON
ADDITIONAL = OrderedDict([

    # This list should correspond to listing in
    # https://researchobject.github.io/ro-crate/0.3-DRAFT/#additional-metadata-standards


          ("File", "http://schema.org/MediaObject"),
          ("path", "http://schema.org/contentUrl"),
          ("Journal", "http://schema.org/Periodical"),

          ("cite-as", "https://www.w3.org/ns/iana/link-relations/relation#cite-as"),
          ("hasFile", "http://pcdm.org/models#hasFile"),
          ("hasMember", "http://pcdm.org/models#hasMember"),
          ("RepositoryCollection", "http://pcdm.org/models#Collection"),
          ("RepositoryObject", "http://pcdm.org/models#object"),

          # Temporary namespace for properties/types
          # proposed https://bioschemas.org/profiles/Workflow/ draft 0.5
          # Remove if/when added to schema.org release!
          ## BEGIN
          ("Workflow", BIOSCHEMA_WORKFLOW_NS),
          ("input", BIOSCHEMA_WORKFLOW_NS + "#input"),
          ("output", BIOSCHEMA_WORKFLOW_NS + "#output"),
          ("FormalParameter", BIOSCHEMA_FORMAL_PARAMETER_NS),
          # https://github.com/schemaorg/schemaorg/issues/383#issuecomment-651040576
          ("funding", "http://schema.org/funding"),
          ## END 

          ("wasDerivedFrom", "http://www.w3.org/ns/prov#wasDerivedFrom"),
          
          ("importedFrom", "http://purl.org/pav/importedFrom"),
          ("importedOn", "http://purl.org/pav/importedOn"),
          ("importedBy", "http://purl.org/pav/importedBy"),

          ("retrievedFrom", "http://purl.org/pav/retrievedFrom"),
          ("retrievedOn", "http://purl.org/pav/retrievedOn"),
          ("retrievedBy", "http://purl.org/pav/retrievedBy"),

          ("conformsTo", "http://purl.org/dc/terms/conformsTo"),

          ("@label", "http://www.w3.org/2000/01/rdf-schema#label"),

          ("pcdm", "http://pcdm.org/models#"),
          ("bibo", "http://purl.org/ontology/bibo/"),
          ("cc", "http://creativecommons.org/ns#"),
          ("dct", "http://purl.org/dc/terms/"),
          ("foaf", "http://xmlns.com/foaf/0.1/"),
          ("rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#"),
          ("rdfa", "http://www.w3.org/ns/rdfa#"),
          ("rdfs", "http://www.w3.org/2000/01/rdf-schema#"),
          ("schema", "http://schema.org/"),
          ("frapo", "http://purl.org/cerif/frapo/"),
          ("rel", "https://www.w3.org/ns/iana/link-relations/relation#"),
          ("pav", "http://purl.org/pav/"),
          ("prov", "http://www.w3.org/ns/prov#"),
          ("wfdesc", "http://purl.org/ro/wfdesc#"),
          ("wfprov", "http://purl.org/ro/wfprov#"),
          ("roterms", "http://purl.org/ro/roterms#"),
          ("wf4ever", "http://purl.org/ro/wf4ever#"),
          # Disabled, see https://github.com/ResearchObject/ro-crate/pull/73
#          ("@base", None) 
])

if __name__=="__main__":
  main()
