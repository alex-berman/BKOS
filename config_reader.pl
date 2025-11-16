:- module(config_reader, [read_yaml_config/2]).
:- use_module(library(yaml)).

read_yaml_config(Path, Result) :-
    json_read(Path, Result).


read_tests(TestsPath, TestsDict) :-
    yaml_read(TestsPath, RawDict),
    process_potential_imports(RawDict, TestsDict).

process_potential_imports(RawDict, Result) :-
    ( get_dict(import, RawDict, Imports) ->
        process_imports(RawDict, Imports, Result)
    ;
        Result = RawDict
    ).

process_imports(Dict, [], Dict).
process_imports(InputDict, [Path|Rest], OutputDict) :-
    yaml_read(Path, ImportedDict),
    InputDict.put_dict(ImportedDict, OutputDict1),
    process_imports(OutputDict1, Rest, OutputDict).

