# SAP Documentation Data Set for Machine Translation
A parallel evaluation data set of SAP software documentation with document structure annotation

## Overview
The data in this project is released by SAP for the [7th Workshop on Asian Translation (WAT 2020)](https://lotus.kuee.kyoto-u.ac.jp/WAT/WAT2020/index.html) for the IT Documentation Translation Task. The data originates from the [SAP Help Portal](https://help.sap.com/) that contains SAP product documentation and user assistance for product-related questions. The current language scope is English to Hindi, Indonesian, Malay and Thai. The data may be used for research purposes only.

The data has been processed in a way that makes it suitable as development and test data for machine translation purposes. For each language pair about 4k segments are available, split into development and test data. The segments are provided in their document context and are annotated with additional metadata from the document. The details are described below.

The test data will be released one week before the WAT 2020 submission deadline.


## Language scope
| **Language pair** | **Abbreviation** |
| --- | --- |
| English-Hindi | `enhi` |
| English-Indonesian | `enid` |
| English-Malay | `enms` |
| English-Thai | `enth` |

## Data Format
The data is represented in three text files that are aligned on segment level: source, target and metadata, see table below. `xx` stands for the respective target language. All files are utf-8 encoded.

| **File name** | **Content** |
| --- | --- |
| `sap_documentation.dev.enxx.en` | source segments of development set  |
| `sap_documentation.dev.enxx.xx` | target segments of development set  |
| `sap_documentation.dev.enxx.meta` | metadata of the source-target pairs of the development set (tab separated) |
| `sap_documentation.test.enxx.en` | source segments of test set (to be released later) |
| `sap_documentation.test.enxx.xx` | target segments of test set (to be released later) |
| `sap_documentation.test.enxx.meta` | metadata of the source-target pairs of the test set (tab separated) (to be released later) |

## Document context metadata
For each segment pair, positional metadata was recorded to serve the goal of providing context information.  It is available in the `*.meta` file, aligned with the source and target segments, containing the following 5 columns: 

| **Column** | **Description of column content** |
| --- | --- |
| 1 | Document ID |
| 2 | Segment ID in the document that indicates the contextual order (restarts from 1 in each document) |
| 3 | Text Unit ID in the document that indicates segments that occur in consecutive order (starts from 1 in each document). Segments with the same Text Unit ID make up one text block consisting of multiple sentences, for example a paragraph. |
| 4 | Segment ID in Text Unit (starts from 1 in each Text Unit) |
| 5 | Textual element that describes the structural type of the segment. Values are `title`, `section`, `table_element`, `list_element`, `example`, `unspecified` |

## Particularities
* There is some *redundancy* in these data sets, i.e. source-target pairs that occur several times within the test or development file. As the content is taken from SAP Help pages, it is natural that subtitles, table headers, or even table values might occur several times within and across documents. 
Obviously, duplicates cannot simply be removed if we want to keep the contextual order of segments. But we put some effort in the data selection to keep the overall redundancy at a minimum. 
* As SAP Help pages contain lots of tables and list items, many *translation segments are short*, sometimes consisting of just a number or a word. 
* There is a large number of *short documents* reflecting the segmentation of help page content.


## License
This project is licensed under [Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)](LICENSE) except as noted otherwise in the [LICENSE](LICENSE) file.

Please cite

Bianka Buschbeck, Miriam Exel (to appear). 
"Introduction of the SAP Documentation Data Set for Machine Translation" 

when you use this data set.


