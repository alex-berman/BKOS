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
    get_dict(inherit, In, ResourceKeyStrings),
    !,
    ( is_list(ResourceKeyStrings) ->
        process_inherited_resources(RootIn, In, ResourceKeyStrings, Out)
    ;
        throw(error(type_error(list, ResourceKeyStrings), RootIn))
    ).
process_inherit(RootIn, In, Out) :-
    is_dict(In),
    !,
    dict_pairs(In, Tag, PairsIn),
    process_inherit_pairs(RootIn, PairsIn, PairsOut),
    dict_pairs(Out, Tag, PairsOut).
process_inherit(_, X, X).

process_inherited_resources(_, X, [], X).
process_inherited_resources(RootIn, In, [ResourceKeyString|Rest], Out) :-
    atom_string(ResourceKey, ResourceKeyString),
    ( get_dict(ResourceKey, RootIn, Resource) ->
        merge_dicts(In, Resource, Out1),
        process_inherited_resources(RootIn, Out1, Rest, Out)
    ;
        throw(error(existence_error(resource, ResourceKey), RootIn))
    ).

process_inherit_pairs(_, [], []).
process_inherit_pairs(RootIn, [Key-In|RestIn], [Key-Out|RestOut]) :-
    process_inherit(RootIn, In, Out),
    process_inherit_pairs(RootIn, RestIn, RestOut).

merge_dicts(In1, In2, Out) :-
    findall(Key, get_dict(Key, In1, _), Keys1),
    findall(Key, get_dict(Key, In2, _), Keys2),
    union(Keys1, Keys2, Keys),
    merge_pairs(Keys, In1, In2, PairsMerged),
    dict_pairs(Out, yaml, PairsMerged).

merge_pairs([], _, _, []).
merge_pairs([Key|RestKeys], In1, In2, [Key-Value|Rest]) :-
    merge_value(Key, In1, In2, Value),
    merge_pairs(RestKeys, In1, In2, Rest).

merge_value(Key, In1, In2, Value) :-
    ( get_dict(Key, In1, Value1) ->
        ( get_dict(Key, In2, Value2) ->
            ( is_list(Value1) ->
                ( is_list(Value2) ->
                    append(Value1, Value2, Value)
                ;
                    throw(error(type_error(list, Value2), In2))
                )
            ;
                throw(error(type_error(list, Value1), In1))
            )
        ;
            Value = Value1
        )
    ;
        get_dict(Key, In2, Value)
    ).
