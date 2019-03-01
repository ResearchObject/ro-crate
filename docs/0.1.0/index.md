# ROLite 0.1.0

This first draft of [ROLite](../) is more of a dump to initiate discussion.

This example is based on [DataCrate](https://github.com/UTS-eResearch/datacrate) and [BioSchemas](http://bioschemas.org/specifications/), bringing in Research Object vocabularies where appropriate.

1. Table of Contents
{:toc}

## Explaining by example: a simple dataset

[simple-dataset-0.1.0](https://github.com/ResearchObject/ro-lite/tree/master/examples/simple-dataset-0.1.0) shows an example of a fairly minimal dataset, which can live in GitHub, be distributed as a ZIP archive, posted to Zenodo etc.

![Root folder of RO](img/simple-dataset-0.1.0/root.png)

The files of the dataset are under [`data/`](https://github.com/ResearchObject/ro-lite/tree/master/examples/simple-dataset-0.1.0/data), which mean this folder structure could later be upgraded to be a BagIt archive ([RFC8493](https://www.rfc-editor.org/rfc/rfc8493.txt)).

![data/ folder](img/simple-dataset-0.1.0/data-folder.png)

Here are our files described in this ROLite example:

* `repository-sizes.tsv` and `repository-sizes.ods` - our main dataset in raw tab-separated format and organized as a spreadsheet
* `repository-sizes-chart.png` - a chart from the spreadsheet
* `logs/` - various log files

To describe these resources and their relations, ROLite has a single file [manifest.jsonld](https://github.com/ResearchObject/ro-lite/blob/master/examples/simple-dataset-0.1.0/manifest.jsonld)

The JSON file is split into a couple of logical parts that in total make out the schema.org description in JSON-LD of both the dataset and the Research Object.

### Preamble

```jsonld
{
    "@context": ["http://schema.org", "https://w3id.org/bundle/context"],
    "@type": ["ro:ResearchObject", "Dataset"],   
    "@id": ".",
    "identifier": "976287d8886dbc477272976658598b1764493a3e",
}
```

The `@context` means we are using JSON keys from both `schema.org` and Research Object. The default vocabulary is schema.org, but the RO vocabularies can override (shown using the `ro:` etc below)

**TODO: Alternative bundle-independent context for research objects**

The `@type` shows we are dealing with a Research Object, in particular one that is also a <http://schema.org/Dataset>.

The `@id` shows that the Research Object is the current directory. Note: other RO serializations have `manifest.json` in subdirectories like `.ro` or `metadata/`; here it is in the root folder to avoid relative climbs like `../data/`.

While the current directory is a good root, it is also a relative identifier, meaning that any copy or publication of this RO will effectively have a different `@id`. This is on purpose, in case they get edited. However it is always good practice to assign a more durable and unique identifier (see [Identifiers for the 21st century](https://doi.org/10.1371/journal.pbio.2001414)), which can be provided using the <http://schema.org/identifier> property. The value should ideally be a URI (e.g. `https://doi.org/10.17632/6wtpgr3kbj.1`), but in this example use a local (but unique) git commit ID.

## Dataset description

```jsonld
    "name": "Dataset of repository sizes in CWL Viewer",
    "description": "This is a simple dataset showing the size in bytes of the repositories examined by https://view.commonwl.org/ sinze September 2018",
    "keywords": "CWL, repository, example",    
    "temporalCoverage": "2018-09/2019-01",
    "contentLocation": {
            "@id": "http://sws.geonames.org/9884115/",
            "name": "Kilburn Building, Manchester, UK"
    }
```

**TODO**: Complete field descriptions.


## Next step: Workflow research object

The example [workflow-0.1.0](https://github.com/ResearchObject/ro-lite/tree/master/examples/workflow-0.1.0) shows a more complex example of a Research Object containing a workflow.

In this example there is both `workflow/` `tools/` and `test/` - but no `data/` payload.

This example shows how RO Lite can be used with a non-trivial pre-existing directory structure. In particular the [workflow/](https://github.com/ResearchObject/ro-lite/tree/master/examples/workflow-0.1.0/workflow) folder is actually a KNIME workspace folder that contain a [KNIME workflow](https://www.knime.com/) and its contained input and output data in the internal format used by KNIME. 

The Research Object [manifest.jsonld](https://github.com/ResearchObject/ro-lite/blob/master/examples/workflow-0.1.0/manifest.jsonld#L39) only highlight a couple of these files:

```json
aggregates: [
        {
            "@id": "workflow/workflow.knime",
            "@type": ["SoftwareSourceCode", "wfdesc:Workflow"],
            "name": "RetroPath 2.0 Knime workflow",
            "description": "KNIME implementation of RetroPath2.0 workflow",
            "creator": {
                    "name": "Thomas Duigou",
                    "email": "thomas.duigou@inra.fr"
            },
            "programmingLanguage": {
                "name": "KNIME Analytics Platform",
                "url": "https://www.knime.com/knime-software/knime-analytics-platform",
                "version": "3.6"
            },
            "url": "https://www.myexperiment.org/workflows/4987"
        }
# ...
```

Here http://schema.org/programmingLanguage is used informally to indicate the workflow system used. 

In addition the `workflow/` folder, the KNIME workspace that captures the internal workflow state, is listed as an `ExampleRun`. 

```json
        {
            "@id": "workflow/",
            "@type": ["roterms:ExampleRun"],
            "description": "KNIME workspace after executing RetroPath2.0 workflow"
        }
```

