# Software Documentation Data Set for Machine Translation

[![REUSE status](https://api.reuse.software/badge/github.com/SAP/software-documentation-data-set-for-machine-translation)](https://api.reuse.software/info/github.com/SAP/software-documentation-data-set-for-machine-translation)

A parallel evaluation data set of SAP software documentation with document structure annotation

## Overview
The data in this data set originates from the [SAP Help Portal](https://help.sap.com/) that contains documentation for SAP products and user assistance for product-related questions. The current language scope is English to Asian languages including Hindi, Indonesian, Japanese, Korean, Malay, Thai, Vietnamese, Simplified Chinese and Traditional Chinese; Additionally, we provide data for English to other European languages including German, Spanish, French, Italian, Portuguese and Russian. The data may be used for research purposes only.

The data has been processed in a way that makes it suitable as development and test data for machine translation purposes. For each language pair about 4k segments are available, split into development and test data. The Asian language data is under the folder `document_translation` while the European data is under the folder `term_postedits`.

The Asian language data contains additional information about document structure while the European language data contains machine translations, post-edits, and terms. A full read-me is provided in each sub-folder.

### Document Structure

The segments are provided in their document context and are annotated with additional metadata from the document. The details are described below. More information can be found in [Buschbeck and Exel (2020)](https://arxiv.org/abs/2008.04550).

The data for the language pairs English to Japanese, Korean, Simplified and Traditional Chinese is special in two ways:
* It is multilingual, 4-way parallel, meaning the source is the same for all four target languages.
* We also release the full document structure for each document that is part of the data set. See below for more information.

The _software documentation data set for machine translation_ was initially released by SAP for the [7th Workshop on Asian Translation (WAT 2020)](https://lotus.kuee.kyoto-u.ac.jp/WAT/WAT2020/index.html). It was also used in the [8th Workshop on Asian Translation (WAT 2021)](http://lotus.kuee.kyoto-u.ac.jp/WAT/WAT2021/index.html). It was extended with additional language pairs and structured documents for the [9th Workshop on Asian Translation (WAT 2022)](https://lotus.kuee.kyoto-u.ac.jp/WAT/WAT2022/index.html). Note that for this extension currently only the development data has been released. The test data will follow shortly before the deadline of the shared task.

### Term Postedits

The segments in the `term_postedits` folder are provided without document context or additional metadata but instead contain two translations of each source sentence. One translation was produced directly by neural machine translation (NMT) systems while the other translation was produced by human translators correcting the NMT systems' output. These are identified by the file endings `.mt` and `.pe` respectively. Additionally, we provide term triples for a subset of the data.

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

## Contributing
We welcome contributions to this project. Please see the [contribution guidelines](https://github.com/SAP/.github/blob/main/CONTRIBUTING.md) for more details on how to contribute.
