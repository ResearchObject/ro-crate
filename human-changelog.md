# Human changelog 1.2

Profile conformance SHOULD be declared on the _Root Data Entity_ rather than on the _RO-Crate 
Metadata Descriptor_ where conformance to the base RO-Crate specification is declared. 
This is because the profile applies to the whole RO-Crate, and may cover aspects beyond 
the crate's metadata file (e.g. identifiers, packaging, purpose).

(include an example)

profiles#declaring-conformance-of-an-ro-crate-profile

Metadata descriptor [about] now has **a single value** (previously unconstrained).
> This descriptor MUST have an [about]
property with a single value referencing the _Root Data Entity_'s `@id`.

Removed requirement for the RO-Crate JSON-LD to be included in the HTML header of the RO-Crate Website - as "there is no evidence that this has been useful".
