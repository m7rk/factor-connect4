! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays kernel sequences math io ;
IN: c4

! get nth element of array and put on top of stack, without destroying the array.
: npush ( idx ary -- idx ary n ) over over nth ;

! recombine an array and save it - use picks to get things in order
: ncomb ( idx srcary e -- srcary ) over [ pick pick set-nth drop drop ] dip ;

! generate boardstate
: mkboard ( -- out ) 8 { 0 0 0 0 0 0 0 0 } <array> [ clone ] map ;

! return true/false if piece should be moved down, and puts it on top of stack
: shoulddroppiece ( ary idx -- ary idx result ) dup 7 < [ over over 1 + swap nth 0 = ] [ f ] if ;

! delete old position of piece
: cleanpiece ( ary idx -- ary idx ) over over swap [ [ 0 ] dip ] dip set-nth ;

! drop piece down one array
: droppiece ( ary idx -- ary idx ) over over swap [ [ 1 ] dip 1 + ] dip set-nth ;

! gravity runs until stoppiece fails or reaches bottom. if it was false we can just return since we consumed the index already
: gravity ( ary idx -- ary ) shoulddroppiece [ cleanpiece droppiece 1 + gravity ] [ drop "finished!" print ] if ;

! put piece at top of array
: addpiece ( ary -- modary ) dup [ 1 0 ] dip set-nth ;

! duplicate target row from the board and set the zero for iteration
: exc4 ( move board -- board ) npush addpiece 0 gravity ncomb ;

