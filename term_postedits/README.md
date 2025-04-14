# Software Documentation Data Set for Machine Translation

[![REUSE status](https://api.reuse.software/badge/github.com/SAP/software-documentation-data-set-for-machine-translation)](https://api.reuse.software/info/github.com/SAP/software-documentation-data-set-for-machine-translation)

A parallel evaluation data set of SAP software documentation with document structure annotation

## Overview
The data in this data set originates from the [SAP Help Portal](https://help.sap.com/) that contains documentation for SAP products and user assistance for product-related questions. The current language scope is English to Hindi, Indonesian, Japanese, Korean, Malay, Thai, Vietnamese, Simplified Chinese and Traditional Chinese. The data may be used for research purposes only.

The data has been processed in a way that makes it suitable as test data for machine translation purposes. For each language pair about 2k segments are available. The segments are provided without document context and are annotated with terminology. The details are described below.

## Language scope

| **Language pair** | **Abbreviation** |
| --- | --- |
| English - German | `ende` |
| English - Spanish | `enes` |
| English - Italian | `enit` |
| English - French | `enfr` |
| English - Portuguese | `enpt` |
| English - Russian | `enru` |

## Data Format
The plain-text data is represented in four text files that are aligned on segment level: source, machine translation, post-edit, and terms. `xx` stands for the respective target language. All files are utf-8 encoded.

| **File name** | **Content** |
| --- | --- |
| `term_postedits.test.enxx.src` | source segments of test set  |
| `term_postedits.test.enxx.mt` | machine translation segments of test set  |
| `term_postedits.test.enxx.pe` | post-edited translation of the test set |
| `term_postedits.test.enxx.terms` | Term triples for the source, machine translation, and post-edits of the test set |

The term triples are contained in a `.term` file. Each line in the `.term` file corresponds to the same line in the `.src`, `.mt`, and `.pe` files and is formatted as a python list of tuples. That means that each line contains

```
[('Source Term1', 'MT Term1', 'PE Term1'), ('Source Term2', 'MT Term2', 'PE Term2')]
```

with a tuple given per term occuring in the source, MT, and post-edit. Because we were specifically interested in the scenario where terms are edited, we only provide terms for lines where the source, MT, and post-edit all contain valid terms, but the MT and post-edit differ with which term translation they use.

### Term Postedits

The segments in the `term_postedits` folder are provided without document context or additional metadata but instead contain two translations of each source sentence. One translation was produced directly by neural machine translation (NMT) systems while the other translation was produced by human translators correcting the NMT systems' output. These are identified by the file endings `.mt` and `.pe` respectively. Additionally, we provide term triples for a subset of the data.

### Terms

All terms were found in [SAPTerm](https://www.sapterm.com/sap/bc/webdynpro/sap/sterm_webaccess#). SAPTerm is a one-to-many terminology dictionary, meaning that a term in the source language can have multiple possible term translations. In order to construct our terminology annotation we first search for any valid term in our source segment by using [RapidFuzz](https://github.com/rapidfuzz/RapidFuzz). We use it's `partial_ratio_alignment` function with a threshold of `0.95` to allow for approximate matches in order to search for all valid terms in our source segment.

Once we have located a term in our source, we then search both the MT and post-edit for valid translations of the source term. If we find that both the MT and post-edit contain terms but that they disagree on the correct term translation, we add this triple to our `.terms` file. If the MT and post-edit agree with regards to terms or if either the MT or post-edit do not contain terms, then we do not add a corresponding entry in our `.terms` file.

If no terms were added, then we insert the empty list `[]` to our `.terms` file. This indicates that we did not find a term triple that met the conditions above and ensures that our segments and terms are stilled aligned.
