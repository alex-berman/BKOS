BKOS (pronounced _because_) is a dialogue manager for **conversationally explainable AI (XAI) interfaces**, informed by theories of human argumentation, rhetoric and dialogue, and by empirical analyses of human explanatory dialogues. In BKOS, explanations are conceived as arguments for claims, and the structure of those arguments is extracted from information (so called coefficients) learned by the statistical model.

# Capabilities

BKOS' conversational capabilities are described in Alexander Berman's PhD thesis (in preparation).

# Version

This repository contains BKOS version 2, implemented in SWI Prolog. Note that there is a [previous version of BKOS](https://github.com/alex-berman/BKOS), implemented in Python.


# Running the system

There is currently no interactive version of the system. However, [dialogue coverage tests](test/dialog_coverage_spinal_stenosis.yml) can be validated by running

```
swipl -g run_tests -t halt test/test_bkos.pl
```

# Debugging and tracing with coverage testing
SWI Prolog's support for debugging and tracing can be useful when troubleshooting test failures. If we assume that the test named `explain_claim_with_exact_data` is failing and we want to understand why, we can, e.g. insert a `trace` invocation somethere in the code, and then run the test as follows:

```
swipl -g "run_test('test/dialog_coverage_spinal_stenosis.yml', explain_claim_with_exact_data)" test/test_bkos.pl
```

This will execute the selected test until the trace point is encountered.

# Contact
For correspondence, contact alexander.berman@gu.se
