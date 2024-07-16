---
page_id: tlcmap
title: Time Layered Cultural Map (TLCMap)
description: TLCMap is a set of tools that work together for mapping Australian history and culture which includes downloads of geographical data packaged in RO-Crate
url: https://example.org/
image: tlcmap.png
domains: [humanities, ecology, climate_science, language_text] # should match item(s) in pages/domains
tasks: [conduct_research] # should match item(s) in pages/tasks
roles: [researcher, software_developer] # should match item(s) in pages/roles
---
<!--
   Copyright 2019-2022 RO-Crate contributors
   <https://github.com/ResearchObject/ro-crate/graphs/contributors>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

# Time Layered Cultural Map (TLCMap)

> The Time-layered Cultural Map of Australia (TLCMap) is an online research platform
funded by the Australian Research Council Linkage Infrastructure, Equipment and 
Facilities (LIEF) grant scheme in 2019 and currently under development. When completed, 
it will deliver researcher-driven national-scale infrastructure for the humanities,
focused on mapping, time series, and data integration, and will expand the use of Australian cultural and historical data for research through sharply defined and powerful
discovery mechanisms. 
>
> The main function of TLCMap is to generate web-based digital time-maps from spatiotemporal data for humanities’ needs, including time, layering, data, text, media, and
virtual reality applications. Linking geo-spatial maps of Australian cultural and historical information, adapted to time series, represents a significant contribution to humanities research in Australia. For researchers, including those without extensive technical
backgrounds, it has the potential to transform access to data and to visualisation tools
and open new perspectives on Australian culture and history. For the public, it will
enable increased accessibility to historical and cultural data through visualisations created by researchers and made available online and in print. [[1]](#tlcmap-paper)

TLCMap uses RO-Crate for exporting geographical search results and map layers via the Gazeteer of Historical Australian Places (GHAP) service.

 ![Screenshot of GHAP showing a bounding box on a map](assets/img/ghap-screenshot.png)



## RO-Crate Export


Below is an example of a search for "Katoomba" (the name of a town in New South Wales), which returns a zip file containing csv, kml, and geojson files.

```
curl "https://ghap.tlcmap.org/places?containsname=katoomba&searchausgaz=on&searchncg=on&searchpublicdatasets=on&format=rocrate&download=on"

{
    "@context": "https://w3id.org/ro/crate/1.1/context",
    "@graph": [
        {
            "@type": "CreativeWork",
            "@id": "ro-crate-metadata.json",
            "conformsTo": {
                "@id": "https://w3id.org/ro/crate/1.1"
            },
            "about": {
                "@id": "./"
            }
        },
        {
            "@id": "./",
            "@type": "Dataset",
            "datePublished": "2024-07-04",
            "name": "GHAP search results",
            "description": "Export of search results data from GHAP",
            "url": "https://ghap.tlcmap.org/search?containsname=katoomba&searchausgaz=on&searchncg=on&searchpublicdatasets=on",
            "hasPart": [
                {
                    "@id": "tlcmap_output.csv"
                },
                {
                    "@id": "tlcmap_output.kml"
                },
                {
                    "@id": "tlcmap_output.json"
                }
            ]
        },
        {
            "@id": "tlcmap_output.csv",
            "@type": "File",
            "name": "CSV export of search results",
            "description": "CSV export of the search results",
            "encodingFormat": "text/csv"
        },
        {
            "@id": "tlcmap_output.kml",
            "@type": "File",
            "name": "KML export of search results",
            "description": "KML export of the search results",
            "encodingFormat": "application/vnd.google-earth.kml+xml"
        },
        {
            "@id": "tlcmap_output.json",
            "@type": "File",
            "name": "GeoJSON export of search results",
            "description": "GeoJSON export of the search results",
            "encodingFormat": "application/geo+json"
        },
        {
            "@id": "#b43872b9-b074-4fc6-b20d-2dd454700378",
            "@type": "CreateAction",
            "instrument": {
                "@id": "https://ghap.tlcmap.org"
            },
            "result": [
                {
                    "@id": "tlcmap_output.csv"
                },
                {
                    "@id": "tlcmap_output.kml"
                },
                {
                    "@id": "tlcmap_output.json"
                }
            ]
        },
        {
            "@id": "https://ghap.tlcmap.org",
            "@type": "SoftwareApplication",
            "url": "https://ghap.tlcmap.org",
            "name": "TLCMap Gazetteer of Historical Australian Places",
            "version": "7.0.0"
        }
    ]
}
```


## Resources

* [TLCMap home page](https://tlcmap.org/)
* [PHP Code implementing RO-Crate](https://github.com/HughCraig/GHAP/tree/main/app/ROCrate)



## Publications

1. <span id="tlcmap-paper"></span>Arthur P, Champion E, Craig H, Gu N, Harvey M, Haskins V, et al. Time-layered cultural map of Australia. In: Digital Humanities in the Nordic Countries Conference [Internet]. 2020 [cited 2024 Jul 4]. Available from: <https://opus.lib.uts.edu.au/bitstream/10453/141441/2/Time%20Layered%20Cultural%20Map%20of%20Australia.pdf>




![TLC Map](assets/img/tlcmap.png)
