:- ensure_loaded(isu_syntax).

% signal_negative_understanding ::
% 	recognized(unresolvable_phrase(Phrase)) -*
% 	utter(icm(understanding, negative, unresolvable_phrase(Phrase))).

% reject_move_with_presupposition_violation :: [
% 	recognized(presupposition(Presupposition)),
% 	^Belief,
% 	$contradicts(Belief, Presupposition),
% 	recognized(move(_))
% 	] -* utter(icm(acceptance, negative, not(Presupposition))).

% reject_unanswerable_question :: [
% 	recognized(move(ask(Q))),
% 	$(\+ valid_answer(Q, _))
% 	] -* utter(icm(acceptance, negative, lack_knowledge)).

mark_move_as_accepted :: [
	recognized(move(Move)),
	*agenda(_)
	] -* accepted(Move).

integrate_question :: [
	accepted(ask(Q)),
	*responded(Q, _)
	] -* [
		qud(Q),
		agenda(respond(Q, user))
	].

integrate_acknowledgement :: [
	accepted(icm(acceptance, positive)),
	^qud(Q)
	] -* agenda(resume(respond(Q, user))).

respond :: [
	agenda(respond(Q, Interrogator)),
	$findall(A, valid_answer(Q, A), ValidAnswers),
	$select_answers(Q, ValidAnswers, SelectedAnswers),
	$answer_move(Q, Interrogator, SelectedAnswers, Move)
	] -* [
		utter(Move),
		responded(Q, SelectedAnswers)
	].

resume_responding :: [
	agenda(resume(respond(Q, Interrogator))),
	$findall(A, (
		valid_answer(Q, A),
		\+ (@responded(Q, As), member(A, As))
	), ValidAnswers),
	$select_answers(Q, ValidAnswers, SelectedAnswers),
	$(SelectedAnswers \== []),
	$answer_move(Q, Interrogator, SelectedAnswers, Move)
	] -* [
		utter([signal_resumption, Move]),
		responded(Q, SelectedAnswers)
	].

argue :: [
	agenda(argue(C)),
	$(Q = [E, M]>>supports(E, C, M)),
	$findall(A, valid_answer(Q, A), ValidAnswers),
	$select_answers(Q, ValidAnswers, SelectedAnswers),
	$normalize(SelectedAnswers, A)
	] -* utter(infer(A, C)).
