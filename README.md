# Software Documentation Data Set for Machine Translation

[![REUSE status](https://api.reuse.software/badge/github.com/SAP/software-documentation-data-set-for-machine-translation)](https://api.reuse.software/info/github.com/SAP/software-documentation-data-set-for-machine-translation)

A parallel evaluation data set of SAP software documentation with document structure annotation

## Overview
The data in this data set originates from the [SAP Help Portal](https://help.sap.com/) that contains documentation for SAP products and user assistance for product-related questions. The current language scope is English to Hindi, Indonesian, Japanese, Korean, Malay, Thai, Vietnamese, Simplified Chinese and Traditional Chinese. The data may be used for research purposes only.

The data has been processed in a way that makes it suitable as development and test data for machine translation purposes. For each language pair about 4k segments are available, split into development and test data. The segments are provided in their document context and are annotated with additional metadata from the document. The details are described below. More information can be found in [Buschbeck and Exel (2020)](https://arxiv.org/abs/2008.04550).

The data for the language pairs English to Japanese, Korean, Simplified and Traditional Chinese is special in two ways:
* It is multilingual, 4-way parallel, meaning the source is the same for all four target languages.
* We also release the full document structure for each document that is part of the data set. See below for more information.

The _software documentation data set for machine translation_ was initially released by SAP for the [7th Workshop on Asian Translation (WAT 2020)](https://lotus.kuee.kyoto-u.ac.jp/WAT/WAT2020/index.html). It was also used in the [8th Workshop on Asian Translation (WAT 2021)](http://lotus.kuee.kyoto-u.ac.jp/WAT/WAT2021/index.html). It was extended with additional language pairs and structured documents for the [9th Workshop on Asian Translation (WAT 2022)](https://lotus.kuee.kyoto-u.ac.jp/WAT/WAT2022/index.html). Note that for this extension currently only the development data has been released. The test data will follow shortly before the deadline of the shared task.


## Language scope
| **Language pair** | **Abbreviation** | **Structured documents** |
| --- | --- | --- |
| English - Hindi | `enhi` | - |
| English - Indonesian | `enid` | - |
| English - Malay | `enms` | - |
| English - Thai | `enth` | - |
| English - Vietnamese | `envi` | - |
| English - Japanese | `enja` | yes |
| English - Korean | `enko` | yes |
| English - Simplified Chinese | `enzh` | yes |
| English - Traditional Chinese | `enzf` | yes |

## Data Format
The plain-text data is represented in three text files that are aligned on segment level: source, target and metadata. `xx` stands for the respective target language. All files are utf-8 encoded.

| **File name** | **Content** |
| --- | --- |
| `software_documentation.[dev\|test].enxx.en` | source segments of development/test set  |
| `software_documentation.[dev\|test].enxx.xx` | target segments of development/test set  |
| `software_documentation.[dev\|test].enxx.meta` | metadata of the source-target pairs of the development/test set (tab separated) |


The data that is available as full structured documents is provided in XLIFF format, one file per document, in a `documents` subfolder per language pair. For convenience, we also provide all translatables segments concatenated, with inline tags in the original DITA format.

| **File name** | **Content** |
| --- | --- |
| `software_documentation.source-text-dita-translatables.[dev\|test].enxx.en` | source segments of development/test set with DITA inline markup (if applicable) |
| `software_documentation.target-text-dita-translatables.[dev\|test].enxx.xx` | target segments of development/test set with DITA inline markup (if applicable) |

### Document context metadata
For each segment plain-text pair, positional metadata was recorded to serve the goal of providing context information.  It is available in the `*.meta` file, aligned with the source and target segments, containing the following 5 columns: 

| **Column** | **Description of column content** |
| --- | --- |
| 1 | Document ID |
| 2 | Segment ID in the document that indicates the contextual order (restarts from 1 in each document) |
| 3 | Text Unit ID in the document that indicates segments that occur in consecutive order (starts from 1 in each document). Segments with the same Text Unit ID make up one text block consisting of multiple sentences, for example a paragraph. |
| 4 | Segment ID in Text Unit (starts from 1 in each Text Unit) |
| 5 | Textual element that describes the structural type of the segment. Values are `title`, `section`, `table_element`, `list_element`, `example`, `unspecified` |

### Structured documents
For `enja`, `enko`, `enzf` and `enzh`, the source and translated data is also provided as complete structured documents including inline markup in XLIFF (`.xlf`) format. File names correspond to document IDs (column 1 in the metadata file).
[XLIFF](https://en.wikipedia.org/wiki/XLIFF) is an XML-based format for storing bitext which was created to standardize the way localizable data is passed between tools in a localization process.

This data has been created by converting it from the original DITA format. 
Much of the original DITA format can be restored by literally using the DITA tags masked by XLIFF tags (`ph`, `bpt`, `ept`).

#### Context Structure
The textual element information in column 5 of the metadata files can also be found in the XLIFF files inside the `context-group/context` element of the nearest `group`. In adddition to the types in the `.meta` files the following types can also appear for "non-text" `trans-unit`s: `concept`, `code`, `related`, `prolog`.


#### Locked references
The documents contain certain placeholders that reference textual content inside or outside the document. In the plain-text data, they have been replaced by `<locked-ref>` as just removing them would render the segments incomplete and ungrammatical.  

In the structured documents, they are represented by `<mrk mtype="protected">` tags and the "hidden" information has been re-inserted inline.

#### Transforming XLIFF files

The XLIFF files can be transformed to more suitable representations for different purposes. As an example, a set of `xsl` stylesheets is provided to transform the XLIFF files to simpler formats. These can be found in the folder `tools` and can be automatically applied by running `SAXONJAR=/the/path/to/saxon-he.jar ./tools/apply-all.sh`.

The provided stylesheets perform the following transformations:

* `XLF12_to_source_text-dita.xsl`: Create file which contains the text and the original tags as masked by the XLIFF tags. This produces a functional DITA file. Locked references are transformed to `<xref>`.
* `XLF12_to_source_text-dita-translatables.xsl`: Create file which contains the text and the original tags as masked by the XLIFF tags. Translate units with the `translate` attribute set to `false` are skipped. This produces a file containing one segment per line which contains DITA tags. Locked references are transformed to `<xref>`.
* `XLF12_to_source_text-plain-translatables.xsl`: Create file which contains only the plain text content. Translate units with the `translate` attribute set to `false` are skipped. This produces a file containing one segment per line which contains no tags. Locked references are transformed to `<locked-ref>`.
* `XLF12_to_source_text-placeholder-translatables.xsl`: Create file which contains the text and XLIFF masking tags `<x>` and `<g>`. Translate units with the `translate` attribute set to `false` are skipped. This produces a file containing one segment per line which contains XLIFF style tags.

* `XLF12_to_target_text-dita.xsl`, `XLF12_to_target_text-dita-translatables.xsl`, `XLF12_to_target_text-plain-translatables.xsl`, `XLF12_to_target_text-placeholder-translatables.xsl`: These are functionally identical as the respective `source` versions from above but act on the `target` text instead of the `seg-source` text. They result in translated versions of the same.

For convenience the results of applying `XLF12_to_source_text-dita-translatables.xsl` and `XLF12_to_target_text-dita-translatables.xsl` and then concatenating all source/target documents is provided as `software_documentation.source-text-dita-translatables.[dev\|test].enxx.en` and `software_documentation.target-text-dita-translatables.[dev\|test].enxx.xx` respectively.

Perquisites: For applying the stylesheets an installation of [Java](https://https://openjdk.java.net/) and a copy of [Saxon](https://www.saxonica.com/download/download_page.xml) is needed.

There also exist multiple open source libraries to process XLIFF files. When working in Java, the [Okapi Framework](https://okapiframework.org/wiki/index.php/Main_Page) provides good support for handling XLIFF files.


## Particularities
* There is some *redundancy* in these data sets, i.e. source-target pairs that occur several times within the test or development file. As the content is taken from SAP Help Portal pages, it is natural that subtitles, table headers, or even table values might occur several times within and across documents. 
Obviously, duplicates cannot simply be removed if we want to keep the contextual order of segments. But we put some effort in the data selection to keep the overall redundancy at a minimum. 
* As SAP Help Portal pages contain lots of tables and list items, many *translation segments are short*, sometimes consisting of just a number or a word. 
* There is a large number of *short documents* reflecting the segmentation of help page content.


## License
This project is licensed under [Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)](LICENSE) except as noted otherwise in the [LICENSE](LICENSE) file.

Please cite

[Bianka Buschbeck and Miriam Exel (2020). 
"A parallel evaluation data set of software documentation with document structure annotation".](https://arxiv.org/abs/2008.04550) 

when you use this data set.

Detailed information including third-party components and their licensing/copyright information is available [via the REUSE tool](https://api.reuse.software/info/github.com/SAP/software-documentation-data-set-for-machine-translation)
