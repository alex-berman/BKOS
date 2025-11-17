:- ensure_loaded(bkos).
:- use_module('test/dialog_testing').

:- begin_tests(dialog_coverage).

test(spinal_stenosis, [forall(get_test(TestAsDict, 'test/dialog_coverage_spinal_stenosis.yml'))]) :-
    run_test_from_dict(TestAsDict).

test(medical, [forall(get_test(TestAsDict, 'test/dialog_coverage_medical.yml'))]) :-
    run_test_from_dict(TestAsDict).

:- end_tests(dialog_coverage).
