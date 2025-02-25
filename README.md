BKOS is a dialogue engine and toolkit for developing **conversationally explainable AI (XAI) interfaces**. BKOS is informed by theories of human argumentation, rhetoric and dialogue, and has several **unique capabilities** when compared with other dialogue-based XAI systems.

# Example
Below is an example of a supported dialogue between a user (green) and the BKOS system (blue) in the context of using a statistical model (in this case logistic regression) to predict an individual's personality on the basis of her music preferences.

![Example dialogue](doc/dialogs/example.png)

# Unique capabilities
BKOS supports the following dialogue capabilities, all of which, as far as I know, are unique when compared with other dialogue-based XAI solutions.

## ✅ Nested explanations
BKOS is capable of explaining its own explanation, when requested by the user.

```
S: I think this person is introverted.
U: Why?
S: The person likes high-energy music.
U: Why do you think so?
S: Music heard by the person has a higher average score for energy than
   music in general.
```

## ✅ Negative understanding feedback
Negative understanding feedback from the user (e.g. "I don't understand", "so what?") causes BKOS to context-dependently elaborate its reasoning.

```
S: I think this person is introverted.
U: I don't understand
S: The person likes non-danceable music.
U: so what?
S: I associate a preference for non-danceable music with being introverted.
```

## ✅ Presupposition violations
If the user's utterance presupposes a false claim, BKOS denies the presupposed content.

```
U: why do think the person is extraverted?
S: No, I don't think this person is extraverted.
```

```
U: how does liking non-danceable music explain being extraverted?
S: No, I don't associate a preference for non-danceable music.
```

```
U: why do you think this person likes non-danceable music?
S: No, I don't think this person likes non-danceable music.
```

## ✅ Yes-no questions
BKOS is capable of answering yes-no questions from the user.

```
U: does the fact that the person likes non-danceable music support the
   assessment that the person is introverted?
S: Yes, I associate a preference for non-danceable music with being
   introverted.
```

## ✅ Additional information
BKOS can deliver answers in chunks, and gives feedback if the user continues requesting additional information when no more chunks are available.

```
S: I think this person is introverted.
U: why?
S: The person likes non-danceable music.
U: any other reasons?
S: The person likes high-energy music.
U: other reasons?
S: The person likes sad/depressed/angry music.
U: other reasons?
S: I don't see any other reasons to believe that the person is introverted.
```

## ✅ Acknowledgement
BKOS silently accommodates acknowledgements from the user.

```
S: I think this person is introverted.
U: ok
S: (utters nothing)
U: why?
S: The person likes high-energy music.    
```

# Publications
Comparison of dialogue capabilities of BKOS and two other conversationally explainable AI interfaces (TalkToModel and Glass-Box):

* Berman, A. and S. Larsson (2025, in prep). Assessing Conversational Capabilities of Explanatory AI Interfaces. In *Proceedings of the International Conference on Artificial Intelligence in HCI, Held as Part of HCI International 2025*. 

Earlier paper outlining the central concepts and ideas in BKOS:

* Berman, A. (2024). [Argumentative Dialogue As Basis For Human-AI Collaboration](https://ceur-ws.org/Vol-3825/short3-2.pdf). In *Proceedings of the Communication in Human-AI Interaction Workshop (CHAI-2024)*.

# Requirements
BKOS has been tested with Python >= 3.8.

# Installation
It is recommended to install and use BKOS inside a virtual environment, e.g. with virtualenv or conda. Then, install BKOS with

```commandline
pip install .
```

# Domains
The repo contains two example domains (use cases): `hello_world` (minimal loan application scenario with pre-determined prediction and explanation) and `music_personality` (more elaborate scenario involving prediction of personality from music preferences).

# Automated testing
The domains contain coverage tests which documented supported dialogue behaviours. The tests can be run as follows:

```commandline
pytest .
```
# Demos
For a web-based demo, see the game [MindTone](https://dev.clasp.gu.se/mindtone/), revolving around estimating persons' personality based on their music preferences. A minimal version of MindTone can be tested in the command line by running

```commandline
bkos interact bkos.music_personality.config
```

Note that the minimal version only supports a single case, without any gaming elements.

This repo also contains a very simple "hello world" demo which can be tested in the command line by running

```commandline
bkos interact bkos.hello_world.config
```

# The name BKOS
The name BKOS combines the word "because" with the notion of KoS (conversation oriented semantics; see J. Ginzburg, Semantics for Conversation, 2008).

# Contact
For correspondence, please contact alexander.berman@gu.se
