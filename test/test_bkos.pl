:- ensure_loaded(bkos).
:- use_module('test/dialog_testing').

:- begin_tests(dialog_coverage).

test(spinal_stenosis, [forall(get_test(TestAsDict, 'test/dialog_coverage/spinal_stenosis.yml'))]) :-
    run_test_from_dict(TestAsDict).

test(medical, [forall(get_test(TestAsDict, 'test/dialog_coverage/medical.yml'))]) :-
    run_test_from_dict(TestAsDict).

test(music_personality, [forall(get_test(TestAsDict, 'test/dialog_coverage/music_personality.yml'))]) :-
    run_test_from_dict(TestAsDict).

:- end_tests(dialog_coverage).
