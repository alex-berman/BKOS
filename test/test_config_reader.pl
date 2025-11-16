:- use_module(config_reader).

:- begin_tests(config_reader).

test(basic_config_without_imports) :-
    setup_call_cleanup(
        tmp_file('tmp.yaml', File),
        (
            setup_call_cleanup(
                open(File, write, Out),
                
    