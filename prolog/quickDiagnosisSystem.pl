/* https://github.com/sjbushra/Medical-Diagnosis-system-using-Prolog/blob/master/medical-diagnosis.pl */

/** <examples>
?-  hypothesis(Disease).
*/


symptom(fever) :- 
verify(" have a fever (y/n) ?").
symptom(rash) :- 
verify(" have a rash (y/n) ?").
symptom(headache) :- 
verify(" have a headache (y/n) ?").
symptom(runny_nose) :- 
verify(" have a runny_nose (y/n) ?").
symptom(conjunctivitis) :- 
verify(" have a conjunctivitis (y/n) ?").
symptom(cough) :- 
verify(" have a cough (y/n) ?").
symptom(body_ache) :- 
verify(" have a body_ache (y/n) ?").
symptom(chills) :- 
verify(" have a chills (y/n) ?").
symptom(sore_throat) :- 
verify(" have a sore_throat (y/n) ?").
symptom(sneezing) :- 
verify(" have a sneezing (y/n) ?").
symptom(swollen_glands) :- 
verify(" have a swollen_glands (y/n) ?").

ask(Question) :-
	write('do you '),write(Question),
	read(Reply),
	( (Reply == yes ; Reply == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.		

verify(S) :-
   (yes(S) -> true ;
    (no(S) -> fail ;
     ask(S))).
	 

hypothesis(german_measles) :-
symptom(fever),
symptom(headache),
symptom(runny_nose),
symptom(rash).

hypothesis(common_cold) :-
symptom(headache),
symptom(sneezing),
symptom(sore_throat),
symptom(runny_nose),
symptom(chills).

hypothesis(measles) :-
symptom(cough),
symptom(sneezing),
symptom(runny_nose).

hypothesis(flu) :-
symptom(fever),
symptom(headache),
symptom(body_ache),
symptom(conjunctivitis),
symptom(chills),
symptom(sore_throat),
symptom(runny_nose),
symptom(cough).

hypothesis(mumps) :-
symptom(fever),
symptom(swollen_glands).

hypothesis(chicken_pox) :-
symptom(fever),
symptom(chills),
symptom(body_ache),
symptom(rash).




