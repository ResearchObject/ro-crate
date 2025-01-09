---
title: Root Data Entity
redirect_from:
  - /1.2-DRAFT/root-data-entity
nav_order: 5
parent: RO-Crate 1.2-DRAFT 
---
<!--
   Copyright 2019-2020 University of Technology Sydney
   Copyright 2019-2024 The University of Manchester UK 
   Copyright 2019-2024 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>

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

# Root Data Entity for a _Valid RO-Crate Dataset_ {#root-data-entity}
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

The **Root Data Entity** is a [Dataset] that represents the RO-Crate as a whole;
a _Research Object_ that includes the _Data Entities_ and the related
_Contextual Entities_.

An RO-Crate is described using _JSON-LD_ by an _RO-Crate Metadata Document_. As explained in section [RO-Crate Structure](structure) this may be stored in an _RO-Crate Metadata File_. In this section we describe the format of the JSON-LD document.


## RO-Crate Metadata Descriptor

The _RO-Crate Metadata Document_ MUST contain a self-describing
**RO-Crate Metadata Descriptor** with
the `@id` value `ro-crate-metadata.json` (or `ro-crate-metadata.jsonld` in legacy
crates for RO-Crate 1.0 or older) and `@type` [CreativeWork]. This descriptor MUST have an [about]
property with a single value referencing the _Root Data Entity_'s `@id`.

```json

{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context", 
  "@graph": [
    {
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.json",
        "about": {"@id": "./"},
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"}
    },
    
    {
      "@id": "./",
      "@type": "Dataset",
      ...
    }
  ]
}
```

{: .note}
> Even in [Detached RO-Crates](structure#detached-ro-crate-packages) which do not have an _RO-Crate Metadata File_ present, the identifier `ro-crate-metadata.json` MUST be used.

The [conformsTo] property of the _RO-Crate Metadata Descriptor_ 
MUST have a single value which is a reference to a versioned permalink URI of the RO-Crate specification starting with `https://w3id.org/ro/crate/`. 

{% include callout.html type="tip" content="In RO-Crate 1,2 The `conformsTo` property MAY not have more than one value, to additionally indicate 
specializing [RO-Crate profiles](profiles) - these SHOULD be referenced from the _Root Data Entity_." %}

### Finding the Root Data Entity

Consumers processing the RO-Crate as a JSON-LD graph can
find the _Root Data Entity_ by following this algorithm:

1. For each entity in `@graph` array
2. .. if the `@id` is `ro-crate-metadata.json`
3. .... from this entity's `about` object, keep the `@id` URI as variable _root_
4. .. if the `@id` is `ro-crate-metadata.jsonld`
5. .... from this entity's `about` object, keep the `@id` URI as variable _legacyroot_
6. For each entity in `@graph` array
7. .. if the entity has an `@id` URI that matches a non-null _root_ return it
8. For each entity in `@graph` array
9. .. if the entity has an `@id` URI that matches a non-null _legacyroot_ return it
10. Fail with unknown root data entity.

Note that the above can be implemented efficiently by first building a map (`entity_map`) of
all entities using their `@id` as keys (which is typically also helpful for
further processing) and then performing a series of lookups. 
Ignoring the legacy case for now, this lookup code could be:

```javascript
metadata_entity = entity_map["ro-crate-metadata.json"]
root_entity = entity_map[metadata_entity["about"]["@id"]]
```

See also the appendix on
[finding RO-Crate Root in RDF triple stores](appendix/relative-uris#finding-ro-crate-root-in-rdf-triple-stores).

### Purpose of Metadata Document

To ensure a base-line interoperability between RO-Crates, and for an RO-Crate to
be considered a _Valid RO-Crate Dataset_, a minimum set of metadata is required for the
_Root Data Entity_. As [stated earlier](structure#self-describing-and-self-contained-local-ro-crate-packages)
the _RO-Crate Metadata Document_ is not an
exhaustive manifest or inventory, that is, it does not necessarily list or
describe all files in the package. For this reason, there are no minimum
metadata requirements in terms of describing [Data Entities](data-entities) (files and folders)
other than the _Root Data Entity_. Extensions of RO-Crate dealing with specific
types of dataset may apply further constraints or requirements of metadata beyond
the Root Data Entity (see the appendix [Extending RO-Crate](appendix/jsonld#extending-ro-crate)).

The _RO-Crate Metadata Descriptor_ MAY contain information such as
licensing for the _RO-Crate Metadata Document_ if metadata is licensed
separately from the crate's Data entities.

The section below outlines the properties that the _Root Data Entity_ MUST have to
be minimally valid.

## Direct properties of the Root Data Entity

The _Root Data Entity_ of _Valid RO-Crate Dataset_ 
Skip to content
Search Gists
All gists
Back to GitHub
@SamHames
SamHames/rocrate_relational.py
Created January 9, 2025 13:31 • Report abuse

Code
Revisions 1
Clone this repository at &lt;script src=&quot;https://gist.github.com/SamHames/b969b4c99300b9c5726bfd5e31c94aba.js&quot;&gt;&lt;/script&gt;
Turn an ROCrate into a relational SQLite schema
rocrate_relational.py
from collections import defaultdict, Counter
import json
import sqlite3
import textwrap


class ROCrateToSQLite:

    def __init__(self, rocrate, db_path):

        self.rocrate = rocrate
        self.db_path = db_path

        self._id_type_map = None
        self.db = sqlite3.connect(self.db_path, isolation_level=None)

    @property
    def id_type_map(self):
        """
        Mapping from a given @id to types of entities.
        Cached on generation as it's needed in a few different places.
        """

        if self._id_type_map is None:
            id_type_map = defaultdict(set)

            for entity in self.rocrate["@graph"]:

                entity_id = entity["@id"]
                entity_type = entity["@type"]

                if isinstance(entity_type, list):
                    for e_t in entity_type:
                        id_type_map[entity_id].add(e_t)
                else:
                    id_type_map[entity_id].add(entity_type)

            self._id_type_map = id_type_map

        return self._id_type_map

    def collect_column_details(self):
        """
        Infer the required columns and their details.
        The details calculated are:
        1. The maximum cardinality (effectively whether the value has 0, 1, or many possible
           values - this effects whether this is a 1:1 relationship or a 1:many relationship)
        2. Whether the values are literal values, references to other tables, or a mixture
           of the two.
        These leads to a choice table for how to represent these relationships:
        cardinality: at most once | many
        reference | nullable fk | bridge table (two sided fk)
        literal | nullable | one:many table
        mixed | (two columns?) | (two or more outrider tables?)
        """

        # The first number is the max cardinality, the second is the set of value kinds
        # literal or reference to another entity observed.
        column_details = defaultdict(Counter)

        for entity in self.rocrate["@graph"]:

            # Mandatory properties
            entity_id = entity["@id"]
            entity_types = entity["@type"]

            if not isinstance(entity_types, list):
                entity_types = [entity_types]

            for key, values in entity.items():
                if key in ("@id", "@type"):
                    continue

                # A value can be a single value, or a list of values - if it's not a
                # list, convert to a list of a single value.
                if not isinstance(values, list):
                    values = [values]

                # Keep cardinality counts for each reference type - there might be
                # arrays of two kinds of information that can be consistently mapped to
                # a single column.
                cardinality_counts = Counter()

                for value in values:
                    # TODO: confirm ROCrate doesn't allow nesting and that @id will
                    # always be present in a valid ROCrate.
                    if isinstance(value, dict):
                        referenced_id = value["@id"]
                        for referenced_type in self.id_type_map[referenced_id]:
                            cardinality_counts[referenced_type] += 1
                    else:
                        # Empty reference -> literal type
                        cardinality_counts[""] += 1

                # Max observed cardinality sets how we model this relationally
                for entity_type in entity_types:
                    for kind, cardinality in cardinality_counts.items():
                        column_details[entity_type][(key, kind)] = max(
                            column_details[entity_type][(key, kind)], cardinality
                        )

        return column_details

    def generate_sql_statements_column_details(self, column_details):
        """
        Generate the necessary SQL table create and insert statements.
        The return represents a dictionary mapping table names to the create table
        statements, and an insert statement that uses named bound parameters that
        can be executed by passing the parameters as a dictionary.
        This also returns an annotated version of column details, mapping the details
        of the ROCrate data back to these generated column names to make inserting data
        a lookup table.
        """

        tables = {}

        annotated_column_details = defaultdict(dict)

        for entity_type, columns in column_details.items():

            cardinality_indexed = defaultdict(list)

            # Break columns into two groups: those containing at most one reference, the
            # primary table, and those containing up to more than one, indicating
            # 1:many or many:many relationships.
            for col, max_cardinality in columns.items():
                # Bucket into two groups: at most one, or more than one
                cardinality_indexed[min(max_cardinality, 2)].append(col)

            # Create the main table for this type (columns of cardinality 1)
            main_table_columns = cardinality_indexed[1]
            column_statements = ["id primary key"]
            insert_keys = ["id"]

            for col_name, ref_table in main_table_columns:
                if ref_table:
                    # Generate a name including the reference table - since a single
                    # entity with a named property can reference any other entity, we
                    # might have multiple columns with the same property names pointing
                    # at different types of things, so we need to split them out.
                    gen_name = f"{col_name}_{ref_table}"
                    column_statements.append(f'"{gen_name}" references "{ref_table}"')
                    insert_keys.append(gen_name)
                    annotated_column_details[entity_type][col_name, ref_table] = (
                        "1:1",
                        entity_type,
                    )
                else:
                    column_statements.append(f'"{col_name}"')
                    insert_keys.append(col_name)
                    annotated_column_details[entity_type][col_name, ref_table] = (
                        "1:1",
                        entity_type,
                    )

            all_columns = ",\n  ".join(column_statements)
            create_table_statement = (
                f'create table "{entity_type}" (\n  {all_columns}\n)'
            )

            # SQLite let's you escape identifiers like table names, but not placeholders
            # for bound parameters, so we need to add an extra layer of indirection
            # here.
            insert_mapping = {key: str(i) for i, key in enumerate(insert_keys)}
            value_bindings = ", ".join(f":{i}" for i, _ in enumerate(insert_keys))
            insert_statement = f'insert into "{entity_type}" values ({value_bindings})'

            tables[entity_type] = (
                create_table_statement,
                insert_statement,
                insert_mapping,
            )

            # Generate 1:many and many:many tables
            for col_name, ref_table in cardinality_indexed[2]:

                table_name = f"{entity_type}_{col_name}"

                # many-many bridge table
                if ref_table:
                    create_table_statement = textwrap.dedent(
                        f"""
                        create table "{table_name}" (
                            "{entity_type}" references "{entity_type}",
                            "{ref_table}" references "{ref_table}",
                            primary key ("{entity_type}", "{ref_table}")
                        )
                        """
                    )
                    insert_statement = (
                        f'insert into "{table_name}" values (:entity_type, :ref_table)'
                    )

                else:
                    create_table_statement = textwrap.dedent(
                        f"""
                        create table "{table_name}" (
                            "{entity_type}" references "{entity_type}",
                            "{col_name}",
                            primary key ("{entity_type}", "{col_name}")
                        )
                        """
                    )
                    insert_statement = (
                        f'insert into "{table_name}" values (:entity_type, :col_name)'
                    )

                annotated_column_details[entity_type][col_name, ref_table] = (
                    "1:many",
                    table_name,
                )

                tables[table_name] = (create_table_statement, insert_statement, {})

        return tables, annotated_column_details

    def insert_rocrate_data(self, sql_statements, annotated_column_details):
        """Insert the rocrate data into the database."""

        try:
            self.db.execute("begin")

            # Drop and create all necessary tables first.

            # TODO: do we want to handle cases where the database already exists
            # separately? Perhaps a default don't overwrite data unless flagged?
            for table_name in sql_statements:
                self.db.execute(f"drop table if exists [{table_name}]")

            for table_statement, _, _ in sql_statements.values():
                self.db.execute(table_statement)

            for entity in self.rocrate["@graph"]:

                # Mandatory properties
                entity_id = entity["@id"]
                entity_types = entity["@type"]

                if not isinstance(entity_types, list):
                    entity_types = [entity_types]

                # TODO: can probably handle multiply typed entities better? This is
                # expanding to one table per type, but I'm pretty sure some of the
                # doubly typed ones are always doubly typed and might be handlable
                # better.
                for entity_type in entity_types:

                    # TODO: add the 'id' column!
                    entity_main = {"id": entity_id}
                    entity_extra_rows = defaultdict(list)

                    for key, values in entity.items():
                        if key in ("@id", "@type"):
                            continue

                        # A value can be a single value, or a list of values - if it's
                        # not a list, convert to a list of a single value.
                        if not isinstance(values, list):
                            values = [values]

                        # Strategy - decompose all of the values into the types, so we
                        # can lookup where they need to be inserted in
                        # annotated_column_details, then insert them with an
                        # accumulated dictionary with the statements. Ultimately this
                        # comes down to two choices: this is either a part of the main
                        # table for the relevant types, in which case we accumulate a
                        # single dict for this entity, or it's one of the :many tables,
                        # in which case we can immediately generate a tuple of data for
                        # inserting.
                        for value in values:

                            if isinstance(value, dict):
                                referenced_id = value["@id"]
                                for ref_table in self.id_type_map[referenced_id]:

                                    cardinality, insert_table = (
                                        annotated_column_details[entity_type][
                                            (key, ref_table)
                                        ]
                                    )

                                    if cardinality == "1:1":
                                        gen_name = f"{key}_{ref_table}"
                                        entity_main[gen_name] = referenced_id

                                    elif cardinality == "1:many":
                                        entity_extra_rows[insert_table].append(
                                            {
                                                "entity_type": entity_id,
                                                "ref_table": referenced_id,
                                            }
                                        )

                            else:
                                cardinality, insert_table = annotated_column_details[
                                    entity_type
                                ][(key, "")]

                                if cardinality == "1:1":
                                    entity_main[key] = value

                                elif cardinality == "1:many":
                                    entity_extra_rows[insert_table].append(
                                        {
                                            "entity_type": entity_id,
                                            "col_name": value,
                                        }
                                    )

                    # Now actually insert the data, mapping the actual names to the
                    # generated insert statements, and generating explicit nulls for
                    # missing data.
                    col_mapping = sql_statements[entity_type][2]
                    entity_main = {
                        value: entity_main.get(key, None)
                        for key, value in col_mapping.items()
                    }
                    self.db.execute(sql_statements[entity_type][1], entity_main)

                    for table, rows in entity_extra_rows.items():
                        self.db.executemany(sql_statements[table][1], rows)

            self.db.execute("commit")

        except Exception:
            self.db.execute("rollback")
            raise


# def insert_rocrate_sql(crate_json, column_specification, db):
#     """
#     Insert the rocrate values into the given database.

#     Assumes that the db has already been setup.

#     """


# column_details = collect_schema_details(crate_json)

# tables = generate_schema_statements(column_details)


# Work plan: Collect additional column information in either collect_column_details or
# generate_schema_statements to enable easier insert processing.

if __name__ == "__main__":
    import requests

    crate_url = (
        "https://data.ldaca.edu.au/api/object/meta"
        "?resolve-parts&noUrid&id=arcp%3A%2F%2Fname%2Chdl10.26180~23961609"
    )

    crate = requests.get(crate_url)

    crate_json = crate.json()

    crater = ROCrateToSQLite(crate_json, "graph.db")

    columns = crater.collect_column_details()
    statements, annotated_columns = crater.generate_sql_statements_column_details(
        columns
    )

    crater.insert_rocrate_data(statements, annotated_columns)
@ptsefton
Comment

Leave a comment
Footer
© 2025 GitHub, Inc.
Footer navigation

    Terms
    Privacy
    Security
    Status
    Docs
    Contact

MUST have the following properties:

*  `@type`: MUST be [Dataset] or an array that contains `Dataset`
*  `@id`:  SHOULD be the string `./` or an absolute URI (see [below](#root-data-entity-identifier))
*  `name`: SHOULD identify the dataset to humans well enough to disambiguate it from other RO-Crates
*  `description`: SHOULD further elaborate on the name to provide a summary of the context in which the dataset is important.
*  `datePublished`: MUST be a single string value in [ISO 8601 date format][DateTime], SHOULD be specified to at least the precision of a day, and MAY be a timestamp down to the millisecond. 
*  `license`: SHOULD link to a _Contextual Entity_ or _Data Entity_ in the _RO-Crate Metadata Document_ with a name and description (see section on [licensing](contextual-entities#licensing-access-control-and-copyright)). MAY, if necessary, be a textual description of how the RO-Crate may be used. 
* `conformsTo` with a value of {"@id": "https://w3id.org/ro/crate/1.2-DRAFT#ro-crate-dataset"} (may be an array with multiple values)

{% include callout.html type="note" content="These requirements are stricter than those published 
for [Google Dataset Search](https://developers.google.com/search/docs/data-types/dataset) which 
requires a `Dataset` to have a `name` and `description`." %}

{% include callout.html type="warning" content="The properties above are not sufficient to generate a [DataCite] citation. Advice on integrating with [DataCite] will be provided in a future version of this specification, or as an implementation guide." %}

Additional properties of _schema.org_ types [Dataset] and [CreativeWork] MAY be added to further describe the RO-Crate as a whole, e.g. [author], [abstract], [publisher]. See sections [contextual entities](contextual-entities) and [provenance](provenance) for further details.


### Root Data Entity identifier

The root data entity's `@id` SHOULD be either `./` (indicating the directory of `ro-crate-metadata.json` is the [RO-Crate Root](structure)), or an absolute URI.


{: note}
> RO-Crates that have been assigned a _persistent identifier_ (e.g. a DOI) MAY indicate this using [identifier] on the root data entity using the approach set out in the [Science On Schema.org guides], that is through a `PropertyValue` or MAY use a full persistent URL as the `@id` for the _Root Data Entity_.
>
> Earlier RO-Crate 1.1 and earlier recommended `identifier` to be plain string URIs. Clients SHOULD be permissive of an RO-Crate `identifier` being a string (which MAY be a URI), or a `@id` reference, which SHOULD be represented as an `PropertyValue` entity which MUST have a human readable `value`, and SHOULD have a `url` if the identifier is Web-resolvable. A citable representation of this persistent identifier MAY be given as a `description` of the `PropertyValue`, but as there are more than 10.000 known [citation styles], no attempt should be made to parse this string.

#### Resolvable persistent identifiers and citation text

It is RECOMMENDED that resolving the `identifier` programmatically returns the _RO-Crate Metadata Document_ or an archive (e.g. ZIP) that contains the _RO-Crate Metadata File_, using [content negotiation](data-entities#retrieving-an-ro-crate) and/or [Signposting]. With an RO-Crate identifier that is persistent and resolvable in this way from a URI, the root data entity SHOULD indicate this using the `cite-as` property according to [RFC8574]. Likewise, an HTTP/HTTPS server of the resolved RO-Crate Metadata Document or archive (possibly after redirection) SHOULD indicate that persistent identifier in its [Signposting] headers using `Link rel="cite-as"`. 

{% include callout.html type="tip" content='The above `cite-as` MAY go to a repository landing page, and MAY require authentication, but MUST ultimately have the RO-Crate as a downloadable item, which SHOULD be programmatically accessible through content negotiation or [Signposting] (`Link rel="describedby"` for a _RO-Crate Metadata Document_, or `Link rel="item"` for an archive). To rather associate a textual scholarly citation for a crate (e.g. journal article), indicate instead a [publication via `citation` property](contextual-entities#publications-via-citation-property).' %}

Any entity which is a subclass of [CreativeWork], including [Dataset]s like the _Root Data Entity_, MAY have a `creditText` property which provides a textual citation for the entity.

## Minimal example of RO-Crate

The following _RO-Crate Metadata Document_ represents a minimal description of an _RO-Crate_ that also follows the identifier recommendations above for use in a _Local RO-Crate Package_. 

```json
{ "@context": "https://w3id.org/ro/crate/1.2-DRAFT/context", 
  "@graph": [

 {
    "@id": "ro-crate-metadata.json",
    "@type": "CreativeWork",
    "about": {"@id": "./"},
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"}
 },  
 {
    "@id": "./",
    "@type": "Dataset",
    "identifier": {"@id": "https://doi.org/10.4225/59/59672c09f4a4b"},
    "cite-as": "https://doi.org/10.4225/59/59672c09f4a4b",
    "datePublished": "2017",
    "name": "Data files associated with the manuscript:Effects of facilitated family case conferencing for ...",
    "description": "Palliative care planning for nursing home residents with advanced dementia ...",
    "license": {"@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/"},
    "creditText": "Agar, M. et al., 2017. Data supporting \"Effects of facilitated family case conferencing for advanced dementia: A cluster randomised clinical trial\". https://doi.org/10.4225/59/59672c09f4a4b"
 },
 {
    "@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/",
    "@type": "CreativeWork",
    "description": "This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/au/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.",
    "identifier": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/",
    "name": "Attribution-NonCommercial-ShareAlike 3.0 Australia (CC BY-NC-SA 3.0 AU)"
 },
 {
    "@id": "https://doi.org/10.4225/59/59672c09f4a4b",
    "@type": "PropertyValue",
    "propertyID": "https://registry.identifiers.org/registry/doi",
    "value": "doi:10.4225/59/59672c09f4a4b",
    "url": "https://doi.org/10.4225/59/59672c09f4a4b"
  }
 ]
}
```

Alternatively the following is also valid:

```json
 {
    "@id": "ro-crate-metadata.json",
    "@type": "CreativeWork",
    "about": {"@id": "https://doi.org/10.4225/59/59672c09f4a4b"},
    "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"}
 },  
{
    "@id": "https://doi.org/10.4225/59/59672c09f4a4b",
    "@type": "Dataset",
    "cite-as": "https://doi.org/10.4225/59/59672c09f4a4b",
    "datePublished": "2017",
    "name": "Data files associated with the manuscript:Effects of facilitated family case conferencing for ...",
    "description": "Palliative care planning for nursing home residents with advanced dementia ...",
    "license": {"@id": "https://creativecommons.org/licenses/by-nc-sa/3.0/au/"},
    "creditText": "Agar, M. et al., 2017. Data supporting \"Effects of facilitated family case conferencing for advanced dementia: A cluster randomised clinical trial\". https://doi.org/10.4225/59/59672c09f4a4b"
 }
```
{% include references.liquid %}
