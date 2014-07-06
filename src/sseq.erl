-module(sseq).
-export([test/0, run/0]).

run() ->
	S_String = "AGCTGACGATATGTAAAGACTCCAAGCGTACAGTCAAGGAGATGGGTCTTGGCCTAGTAATAGACGATTTTTTTATACCCAGTGTTTGTTTAGATTGTGCTAGAGTGAAGTCGGTGGAGCCCCTCCGCACGAATGCGCCACCGGCTCAATCTGGGCCAGTAATATCTGTTCCGCCAAGCTTCCGAAGCCCCTTTACCACTTAGGTTGGTCTGTTATCACCACTTGGACTGGCTACGAAATCAACAAGCTCTAGTCCAAGCAATTTTAATTTGGATGCGTGGTCGTCCGTTAAGCCTTTATGAGCAAAGTTGTCTACAATCCCTTGTTCACACATTTGCACTCGGATATGGATCCCGAATAATCCCTCCCGTCACACCAACGCCCAAAGTATATCTGACCCCATTTTTTTATTCACTCTCAACGCGCTGTGTGTTAGAACTCGGGGTATTAGCATAAATAGTTGGCCACGGTGCAGACCTCGGCGTTTCTTGACAATGCGGTACATCATACCTCTAAGGGTACAAGGCTTAATTATATTGTGTCTCTACTCCGCACGCTACCTTGGAACGATGTCAATACGTGACTCCATATTTGAGTCTGCCCGTATTGAGACTCCCGTCAGGATAGCCTCGGATCTTGAGTCCTTTGACACGTGATGATTTGGGCTAAGGTCGCGCCTCCGTCGGCTAGTGTCAGCTCTAGGCGTGATCCGACTTGAAGCGGCTATCATTTAGGAGATTCTTCGTACATTTTAATGTTTACAGGCTCAGGGCAATCTCCTTTGTCGCATCGTAATGGGCCCCGTTAGCTCTGAACGTGGAGCCGCCGGTGTAATAGTAACCCCGAGGGTAGCAGTTCACGCTCCAGGCCCTTCCCAGGCATTGGGCAGTCTGCTTAGTAA",
	T_String ="ACGGTCCGAGACCGATCCTTTTAGTAGCTTCCACTGTCCCTACGAG",
	S = convert:string_to_dna(S_String),
	T = convert:string_to_dna(T_String),
	Sequence = find_sub_sequence(S, T),
	print_sequence(Sequence).


test() ->
	S_String = "ACGGACGTGACG",
	T_String ="GTA",
	S = convert:string_to_dna(S_String),
	T = convert:string_to_dna(T_String),
	[3,8,10] = find_sub_sequence(S, T),
	perfect.



find_sub_sequence(List, SubSequence) ->
	find_sub_sequence(List, SubSequence, [], 1).

find_sub_sequence([], _SubSequence, _Positions, _Position) ->
	none;
find_sub_sequence(_List, [], Positions, _Position) ->
	lists:reverse(Positions);
find_sub_sequence([Dna1 | RestOfDna1], [Dna2 | RestOfDna2], Positions, Position) when Dna1 =:= Dna2 ->
	find_sub_sequence(RestOfDna1, RestOfDna2, [Position | Positions], Position+1);
find_sub_sequence([_Dna1 | RestOfDna1], SubSequence, Positions, Position) ->
	find_sub_sequence(RestOfDna1, SubSequence, Positions, Position+1).


print_sequence(none) ->
	io:format("NIL~n");
print_sequence([]) ->
	io:format("~n");
print_sequence([Head|Rest]) ->
	io:format(" ~p", [Head]),
	print_sequence(Rest).
