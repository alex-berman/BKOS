:- use_module(config_reader).
:- use_module(library(yaml)).

:- begin_tests(config_reader).

test(basic_config) :-
    setup_call_cleanup(
        tmp_file_stream(Filename, Out, [extension(yml)]),
        (
            yaml_write(Out, _{key: value}),
            close(Out),
            read_yaml_config(Filename, Actual),
            !,
            assertion(Actual.key == "value")
        ),
        delete_file(Filename)
    ).

test(config_with_import) :-
    setup_call_cleanup(
        (
            tmp_file_stream(MainFilename, Main, [extension(yml)]),
            tmp_file_stream(ResourceFilename, Resource, [extension(yml)])
        ),
        (
            yaml_write(Main, _{main_key: main_value, import: [ResourceFilename]}),
            yaml_write(Resource, _{resource_key: resource_value}),
            close(Main),
            close(Resource),
            read_yaml_config(MainFilename, Actual), !,
            assertion(Actual.main_key == "main_value"),
            assertion(Actual.resource_key == "resource_value")
        ),
        (
            delete_file(MainFilename),
            delete_file(ResourceFilename)
        )
    ).

test(config_with_import_and_inherit) :-
    setup_call_cleanup(
        (
            tmp_file_stream(MainFilename, Main, [extension(yml)]),
            tmp_file_stream(ResourceFilename, Resource, [extension(yml)])
        ),
        (
            yaml_write(Main, _{
                import: [ResourceFilename],
                main_key: _{
                    inherit: [resource],
                    content: [main_content]
                }

            }),
            yaml_write(Resource, _{
                resource: _{
                    content: [resource_content]
                }
            }),
            close(Main),
            close(Resource),
            read_yaml_config(MainFilename, Actual), !,
            assertion(Actual.main_key.content == ["resource_content", "main_content"])
        ),
        (
            delete_file(MainFilename),
            delete_file(ResourceFilename)
        )
    ).

test(inherit_adds_key_if_missing) :-
    setup_call_cleanup(
        tmp_file_stream(Filename, Out, [extension(yml)]),
        (
            yaml_write(Out, _{
                resource: _{
                    content: [resource_content]
                },
                key: _{
                    inherit: [resource]
                }
            }),
            close(Out),
            read_yaml_config(Filename, Actual),
            !,
            assertion(Actual.key.content == ["resource_content"])
        ),
        delete_file(Filename)
    ).

:- end_tests(config_reader).
