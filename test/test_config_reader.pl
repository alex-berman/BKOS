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
            assertion(Actual =@= yaml{key: "value"})
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
            assertion(Actual = yaml{
                import: _,
                main_key: "main_value",
                resource_key: "resource_value"
            })
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
                    shared_key: [main_content],
                    main_unique_key: main_unique_value
                }

            }),
            yaml_write(Resource, _{
                resource: _{
                    shared_key: [resource_content],
                    resource_unique_key: resource_unique_value
                }
            }),
            close(Main),
            close(Resource),
            read_yaml_config(MainFilename, Actual), !,
            assertion(Actual = yaml{
                import: _,
                resource: _,
                main_key: yaml{
                    inherit: _,
                    shared_key: ["main_content", "resource_content"],
                    resource_unique_key: "resource_unique_value",
                    main_unique_key: "main_unique_value"
                }
            })
        ),
        (
            delete_file(MainFilename),
            delete_file(ResourceFilename)
        )
    ).

:- end_tests(config_reader).
