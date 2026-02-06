BKOS (pronounced _because_) is a dialogue manager for **conversationally explainable AI (XAI) interfaces**, informed by empirical analyses of human explanatory dialogues.

BKOS is primarily intended for faithfully explaining classifications made by interpretable models with monotonic relationships between features and target, without any interactions between features, e.g. logistic regression and other kinds of generalised linear models.

BKOS' conversational capabilities are described in Alexander Berman's PhD thesis (in preparation).

# Development process
BKOS has been developed through a process of dialogue distillation (Dahlbäck et al. 2000; Larsson et al. 2000). Through this process, human-human dialogues are re-written to analogous human-computer interactions in ways that inform design and implementation of a dialogue system serving in the role of one of the human interlocutors. Specifically, BKOS was developed by distilling the following corpora:

- 12 medical spoken dialogues from 3 empirical sources: doctor-patient consultations from Ahus, anesthesiologists' interactions during neurosurgical operations, and a textbook in medicine focusing on the encounter between patient and doctor
- 35 experimentally collected web chats between laypersons revolving around AI-assisted personality estimation

The distillation process and corpora are furhter described in Berman (forthcoming).

# Validating system behaviour
There is currently no interactive version of the system. However, dialogue coverage tests can be validated by running the test suite:

```
swipl -g run_tests -t halt test/test_bkos.pl
```

The test suite contains:

- [dialog_coverage_medical.yml](test/dialog_coverage_medical.yml): Re-written medical spoken dialogues
- [dialog_coverage_music_personality.yml](test/dialog_coverage_music_personality.yml): Re-written web chats about personality estimation
- [dialog_coverage_spinal_stenosis.yml](test/dialog_coverage_spinal_stenosis.yml): Hypothetical human-computer dialogues in the context of AI-assisted treatment choice for spinal stenosis, serving to document and validate system capabilities

# Debugging and tracing with coverage testing
SWI Prolog's support for debugging and tracing can be useful when troubleshooting test failures. If we assume that the test named `explain_claim_with_exact_data` is failing and we want to understand why, we can, e.g. insert a `trace` invocation somethere in the code, and then run the test as follows:

```
swipl -g "run_test('test/dialog_coverage_spinal_stenosis.yml', explain_claim_with_exact_data)" test/test_bkos.pl
```

This will execute the selected test until the trace point is encountered.

# Version
This repository contains BKOS version 2, implemented in SWI Prolog. Note that there is a [previous version of BKOS](https://github.com/alex-berman/BKOS-py), implemented in Python.

# Contact
For correspondence, contact alexander.berman@gu.se

# References
Jönsson, A.; Dahlbäck, N. Distilling dialogues - A method using natural dialogue corpora for dialogue systems development. In Proceedings of the 6th Applied Natural Language Processing Conference, Seattle, Washington, 2000. Association for Computational Linguistics Stroudsburg, 2000, pp. 44–51.

Larsson, S.; Santamarta, L.; Jönsson, A. Using the process of distilling dialogues to understand dialogue systems. In Proceedings of the Proceedings of ICSLP 2000, 2000, pp. 374–377.

Berman, A. PhD thesis, University of Gothenburg, forthcoming.