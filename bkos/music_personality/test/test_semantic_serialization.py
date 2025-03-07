import pytest

import bkos.music_personality.types
from bkos.music_personality.types import *
from bkos import semantic_serialization


instances = [
    (
        "Extraverted()",
        Extraverted()
    ),
    (
        "Not(Extraverted())",
        Not(Extraverted())),
    (
        "Assert(Not(HighValue(danceability_mean)))",
        Assert(Not(HighValue(danceability_mean)))
    ),
    (
        "Ask(Why(Explains(Not(HighValue(danceability_mean)), Not(Extraverted()))))",
        Ask(Why(Explains(Not(HighValue(danceability_mean)), Not(Extraverted()))))
    ),
    (
        "Ask(Why(HighValue(danceability_mean)))",
        Ask(Why(HighValue(danceability_mean)))
    ),
    (
        "Ask(Why(Not(HighValue(danceability_mean))))",
        Ask(Why(Not(HighValue(danceability_mean))))
    ),
    (
        "Ask(BooleanQuestion(Extraverted()))",
        Ask(BooleanQuestion(Extraverted()))
    ),
    (
        "None",
        None
    )
]


class TestSemanticSerialization:
    @pytest.mark.parametrize('string,object', instances)
    def test_deserialize(self, string, object):
        semantic_serialization.initialize()
        semantic_serialization.register_module(bkos.music_personality.types)
        actual = semantic_serialization.deserialize(string)
        assert actual == object
