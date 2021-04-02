%G3	;TECHNICAL DOUMENTATION FOR %G
	-
	;;    ENTRY POINTS
0	;;top of program, normal entry for printing a global
1	;;same as 0, except other IO device preset
IO	;;normal entry for printing to other IO device
GO	;;module to walk through a global.  Needs % array, %GIOD
KQ	;;kill & quit at the end.  GO leaves variables around.
	-
	;;   VARIABLES
%GP	;;=which space piece of global name specs
%GN	;;=global name
%C	;;=collating sequence: 1 if string, 0 if numeric
%G	;;=global reference, with quotes, commas, etc ex: ^QWE  or ^QWE(1,"HI") 
%DF	;;=$D of last reference
%P	;;=which space piece on current subscript level specs
%N	;;=%GN_"("
%S	;;last subscript
%SQ	;;%S processed with quotes
%SS	;;a upper level %SQ's strung together with commas: ex 1,"HI",
	;;%N_%SS_%SQ_")" assembles to a full global reference
%D	;;the data
%ZN	;;when the program can, it uses $ZOrder.  At that point, %N,%S,%SQ and %SS
	;;become irrelevant.  %ZN is where to start ZOrdering & is checked for
	;;stopping ZOrdering
%ZL	;;=$L(%ZN)
	;;For documentation of % array, see %G1
%L	;;used as stack.  %L=depth (how many subscript levels)
	;;%L(level)=%P
	;;%L(level,0)=%S
	;;%L(level,1)=%SS
	;;%L(level,2)=%SQ
%Q	;;=punt flag.  If set=1, %G aborts.
%X	;;
%GIOD	;;IO device
