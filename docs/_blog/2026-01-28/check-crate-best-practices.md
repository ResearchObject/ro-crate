---
title:  "How I check an RO-Crate follows best practices"
author: ["Eli Chadwick"]
date: 2026-01-28
related_pages:
    use_cases: [] # should match items in pages/use_cases
---

I sometimes get requests to review RO-Crates to see if there's anything that could be improved. Here is the process that I follow when I'm reviewing a crate.

## 1. Automated validation

The first thing to do is check that the RO-Crate is valid according to the specification.

I run the RO-Crate through [`rocrate-validator`](https://github.com/eScienceLab/rocrate-validator?tab=readme-ov-file), which is a Python tool with a command-line interface. `rocrate-validator` can validate against the base RO-Crate specification and the [Workflow](https://about.workflowhub.eu/Workflow-RO-Crate/)/[Workflow Run](https://www.researchobject.org/workflow-run-crate/)/[Workflow Testing](https://lifemonitor.eu/workflow_testing_ro_crate) family of profiles.

This validator can be run with different levels of strictness: by default it will only check MUST/REQUIRED statements from the specification, but it can be set to check SHOULD/RECOMMENDED or even MAY/OPTIONAL statements as well. I normally run at the REQUIRED level first to pull out the highest priority issues, then check again at the RECOMMENDED level to see if there are additional best practices that could be implemented.

```bash
pip install roc-validator
# test MUST/REQUIRED statements
rocrate-validator validate -l required my-crate/
# test SHOULD/RECOMMENDED statements
rocrate-validator validate -l recommended my-crate/
```

Graphical RO-Crate editor tools like [Crate-O](https://language-research-technology.github.io/crate-o/#/), [RO-Crate Playground](https://ro-crate.ldaca.edu.au), and [NovaCrate](https://novacrate.datamanager.kit.edu/) also include validation features. Crate-O in particular has multiple "modes" which validate against different parts of the [Language Data Commons RO-Crate profile](https://github.com/Language-Research-Technology/ldac-profile/blob/master/profile/profile.md).

## 2. Explore the HTML preview

The next step is to ensure that the RO-Crate is usable by humans. My preferred way of doing this is to explore an HTML preview of the crate.

Some crates already come with an `ro-crate-preview.html` file - opening this file in the browser provides an explorable rendering of the crate metadata. For those that don't include it, the file can be easily generated using the [`ro-crate-html`](https://www.npmjs.com/package/ro-crate-html) package.

```bash
npm install -g ro-crate-html
rochtml my-crate/ro-crate-metadata.json
```

In my browser, I will click around to view different entities within the crate and check the connections between them. Some of the things I'm looking out for are:

* entities that aren't referenced correctly (e.g. the referenced entity's id might appear as plain text rather than a link with the entity name)
* entity links where the entity's id is shown and not a human readable name - this indicates that the `name` property needs to be set on the referenced entity
* general ease of navigation - does the crate structure make sense? Can I easily find all the entities by following links in the page?
* general understandability - are all the names and descriptions sensible and human readable? Do I understand what the crate contains?

### Example of checking the HTML preview

Consider the example HTML preview screenshot below.

{% include image.html src="preview-with-issues.png" caption="HTML preview with some issues." alt="RO-Crate HTML preview with issues circled and described in text." border=true %}

There are three issues in this preview:

1. The `name` and `description` rows do not provide a clear explanation of the dataset. They should be reworked to provide a more detailed, human readable description. Including reference numbers is okay, but they should add to the description, not replace it.
1. The `publisher` row shows an ROR identifier reference. This is great for uniquely identifying the publishing organization, but it doesn't help human users to know who the publisher is. The referenced entity should have a `name` property added to make it clearer.
1. The `hasPart` row shows `data.csv` as plain text. `data.csv` is the identifier of another entity within the crate, so the fact that the filename shows as plain text indicates that the entity has not been cross-referenced correctly. In the JSON-LD this error would look like the following:
    ```
    "hasPart": ["data.csv"]
    ```
    when the correct cross-reference should look like this:
    ```
    "hasPart": [{"@id": "data.csv"}]
    ```

Correcting these issues would lead to a preview which looks more like this:

{% include image.html src="preview-without-issues.png" caption="The HTML preview now shows more useful, human readable names." alt="RO-Crate HTML preview with a clear name and description, and human readable names shown for the dataset and publisher." border=true %}

## 3. Cross-check with the spec

Often, the first two steps are sufficient. But sometimes a crate will do something new or unusual, or it will use features of RO-Crate that aren't yet well covered by the automated testing tools. In these cases, I will check anything I'm unsure about against the RO-Crate specification directly (or the relevant profile).

I utilize the [quick reference]({{baseurl}}{% link pages/resources/quick-reference.md %}) resource in conjunction with the full text of the specification - the former provides me a checklist to work through for different types of entity, while the latter provides the necessary context and additional guidance. If I'm providing feedback, I will always send links to the full text rather than the quick reference.

I will focus on specific points of interest - for example, if if there is a nested crate present, I will check against the [Referencing Other RO-Crates]({{baseurl}}{% link _specification/1.2/data-entities.md %}#referencing-other-ro-crates) section (or the corresponding [quick reference section]({{baseurl}}{% link pages/resources/quick-reference.md %}#referenced-ro-crates)).

## 4. Update the crate

I compile the issues I found into a list/document/GitHub review, so they can easily be checked off as they are fixed.

If there are a lot of changes made, it is worth repeating steps 1 and 2 again before finalizing the crate.

You should now have a RO-Crate that is more interoperable, more understandable, and generally more usable by both humans and machines!
