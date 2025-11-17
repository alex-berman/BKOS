:- module(config_reader, [read_yaml_config/2]).
:- use_module(library(yaml)).

read_yaml_config(Path, Result) :-
    yaml_read(Path, RawDict),
    process_potential_imports(RawDict, Result1),
    process_inherit(Result1, Result).

process_potential_imports(RawDict, Result) :-
    ( get_dict(import, RawDict, Imports) ->
        process_imports(RawDict, Imports, Result)
    ;
        Result = RawDict
    ).

process_imports(Dict, [], Dict).
process_imports(InputDict, [Path|Rest], OutputDict) :-
    yaml_read(Path, ImportedDict),
    OutputDict1 = InputDict.put(ImportedDict),
    process_imports(OutputDict1, Rest, OutputDict).


process_inherit(In, Out) :-
    process_inherit(In, In, Out).

process_inherit(RootIn, In, Out) :-
    is_dict(In),
    get_dict(inherit, In, ResourceKeyString),
    !,
    atom_string(ResourceKey, ResourceKeyString),
    ( get_dict(ResourceKey, RootIn, Resource) ->
        merge_dicts(In, Resource, Out)
    ;
        throw(error(existence_error(resource, ResourceKey), RootIn))
    ).
process_inherit(RootIn, In, Out) :-
    is_dict(In),
    !,
    dict_pairs(In, Tag, PairsIn),
    process_inherit_pairs(RootIn, PairsIn, PairsOut),
    dict_pairs(Out, Tag, PairsOut).
process_inherit(_, X, X).

process_inherit_pairs(_, [], []).
process_inherit_pairs(RootIn, [Key-In|RestIn], [Key-Out|RestOut]) :-
    process_inherit(RootIn, In, Out),
    process_inherit_pairs(RootIn, RestIn, RestOut).

merge_dicts(In1, In2, Out) :-
    dict_pairs(In1, Tag, Pairs1),
    dict_pairs(In2, Tag, Pairs2),
    merge_pairs(Pairs1, Pairs2, Pairs),
    dict_pairs(Out, Tag, Pairs).

merge_pairs([], _, []).
merge_pairs([Key-Value1|Rest1], Pairs2, [Key-Value|Rest]) :-
    merge_value(Key, Value1, Pairs2, Value),
    merge_pairs(Rest1, Pairs2, Rest).

merge_value(Key, Values1, Pairs2, Values) :-
    is_list(Values1),
    member(Key-Values2, Pairs2),
    is_list(Values2),
    !,
    append(Values1, Values2, Values).
merge_value(_, Value, _, Value).
