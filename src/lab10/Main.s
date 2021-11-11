	.data
	.globl	_MemMgr_INITIALIZER
_MemMgr_INITIALIZER:
	.word	_NoGC_Init
	.globl	_MemMgr_COLLECTOR
_MemMgr_COLLECTOR:
	.word	_NoGC_Collect
	.globl	_MemMgr_TEST
_MemMgr_TEST:
	.word	0
	.globl	class_nameTab
	.globl	Main_protObj
	.globl	Int_protObj
	.globl	Boolean_protObj
	.globl	String_protObj
	.globl	Symbol_protObj
	.globl	unit_lit
	.globl	boolean_lit0
	.globl	boolean_lit1
	.word	-1
unit_lit:
	.word	7
	.word	3
	.word	Unit_dispTab
	.word	-1
boolean_lit0:
	.word	5
	.word	4
	.word	Boolean_dispTab
	.word	0
	.word	-1
boolean_lit1:
	.word	5
	.word	4
	.word	Boolean_dispTab
	.word	1
	.word	-1
int_lit0:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	0
	.word	-1
int_lit1:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	3
	.word	-1
int_lit8:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	1
	.word	-1
int_lit2:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	50
	.word	-1
int_lit3:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	2
	.word	-1
int_lit4:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	4
	.word	-1
int_lit5:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	7
	.word	-1
int_lit6:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	5
	.word	-1
int_lit7:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	6
	.word	-1
int_lit9:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	8
	.word	-1
int_lit10:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	10
	.word	-1
int_lit11:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	9
	.word	-1
string_lit1:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_lit1
	.ascii	"Any"
	.byte	0
	.align	2
	.word	-1
string_lit11:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit7
	.ascii	"Symbol"
	.byte	0
	.align	2
	.word	-1
string_lit14:
	.word	4
	.word	7
	.word	String_dispTab
	.word	int_lit10
	.ascii	"Statistics"
	.byte	0
	.align	2
	.word	-1
string_lit2:
	.word	4
	.word	17
	.word	String_dispTab
	.word	int_lit2
	.ascii	"/afs/cs.uwm.edu/users/classes/cs654/lib/basic.cool"
	.byte	0
	.align	2
	.word	-1
string_lit10:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit7
	.ascii	"String"
	.byte	0
	.align	2
	.word	-1
string_lit15:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit4
	.ascii	"Main"
	.byte	0
	.align	2
	.word	-1
string_lit16:
	.word	4
	.word	7
	.word	String_dispTab
	.word	int_lit11
	.ascii	"Main.cool"
	.byte	0
	.align	2
	.word	-1
string_lit6:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_lit1
	.ascii	"Int"
	.byte	0
	.align	2
	.word	-1
string_lit7:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit5
	.ascii	"Boolean"
	.byte	0
	.align	2
	.word	-1
string_lit3:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_lit3
	.ascii	"IO"
	.byte	0
	.align	2
	.word	-1
string_lit5:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit4
	.ascii	"Unit"
	.byte	0
	.align	2
	.word	-1
string_lit0:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_lit0
	.byte	0
	.align	2
	.word	-1
string_lit12:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_lit8
	.ascii	"'"
	.byte	0
	.align	2
	.word	-1
string_lit8:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit4
	.ascii	"true"
	.byte	0
	.align	2
	.word	-1
string_lit9:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit6
	.ascii	"false"
	.byte	0
	.align	2
	.word	-1
string_lit13:
	.word	4
	.word	7
	.word	String_dispTab
	.word	int_lit9
	.ascii	"ArrayAny"
	.byte	0
	.align	2
	.word	-1
string_lit4:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_lit4
	.ascii	"null"
	.byte	0
	.align	2
class_nameTab:
	.word	string_lit1
	.word	string_lit15
	.word	string_lit13
	.word	string_lit11
	.word	string_lit10
	.word	string_lit7
	.word	string_lit6
	.word	string_lit5
	.word	string_lit3
	.word	string_lit14
Any_dispTab:
	.word	Any.Any
	.word	Any.toString
	.word	Any.equals
	.word	-1
Any_protObj:
	.word	0
	.word	3
	.word	Any_dispTab
Main_dispTab:
	.word	Any.Any
	.word	Any.toString
	.word	Any.equals
	.word	Main.Main
	.word	Main.factorial
	.word	-1
Main_protObj:
	.word	1
	.word	3
	.word	Main_dispTab
ArrayAny_dispTab:
	.word	Any.Any
	.word	Any.toString
	.word	Any.equals
	.word	ArrayAny.ArrayAny
	.word	ArrayAny.length
	.word	ArrayAny.resize
	.word	ArrayAny.get
	.word	ArrayAny.set
	.globl	ArrayAny_protObj
	.word	-1
ArrayAny_protObj:
	.word	2
	.word	5
	.word	ArrayAny_dispTab
	.word	int_lit0
	.word	0
Symbol_dispTab:
	.word	Any.Any
	.word	Symbol.toString
	.word	Any.equals
	.word	Symbol.Symbol
	.word	Symbol.hashCode
	.globl	Symbol_protObj
	.word	-1
Symbol_protObj:
	.word	3
	.word	6
	.word	Symbol_dispTab
	.word	0
	.word	0
	.word	int_lit0
String_dispTab:
	.word	Any.Any
	.word	String.toString
	.word	String.equals
	.word	String.String
	.word	String.length
	.word	String.concat
	.word	String.substring
	.word	String.charAt
	.word	String.indexOf
	.globl	String_protObj
	.word	-1
String_protObj:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_lit0
	.word	0
Boolean_dispTab:
	.word	Any.Any
	.word	Boolean.toString
	.word	Boolean.equals
	.word	Boolean.Boolean
	.globl	Boolean_protObj
	.word	-1
Boolean_protObj:
	.word	5
	.word	4
	.word	Boolean_dispTab
	.word	0
Int_dispTab:
	.word	Any.Any
	.word	Int.toString
	.word	Int.equals
	.word	Int.Int
	.globl	Int_protObj
	.word	-1
Int_protObj:
	.word	6
	.word	4
	.word	Int_dispTab
	.word	0
Unit_dispTab:
	.word	Any.Any
	.word	Any.toString
	.word	Any.equals
	.word	Unit.Unit
	.word	-1
Unit_protObj:
	.word	7
	.word	3
	.word	Unit_dispTab
IO_dispTab:
	.word	Any.Any
	.word	Any.toString
	.word	Any.equals
	.word	IO.IO
	.word	IO.abort
	.word	IO.out
	.word	IO.is_null
	.word	IO.out_any
	.word	IO.in
	.word	IO.symbol
	.word	IO.symbol_name
	.word	IO.getArgC
	.word	IO.getArg
	.word	-1
IO_protObj:
	.word	8
	.word	3
	.word	IO_dispTab
Statistics_dispTab:
	.word	Any.Any
	.word	Any.toString
	.word	Any.equals
	.word	IO.IO
	.word	IO.abort
	.word	IO.out
	.word	IO.is_null
	.word	IO.out_any
	.word	IO.in
	.word	IO.symbol
	.word	IO.symbol_name
	.word	IO.getArgC
	.word	IO.getArg
	.word	Statistics.Statistics
	.word	Statistics.clear
	.word	Statistics.get
	.word	Statistics.print
	.word	-1
Statistics_protObj:
	.word	9
	.word	3
	.word	Statistics_dispTab
	.text
IO.IO:
	addiu	 $sp $sp -16
	sw	 $fp 16($sp)
	sw	 $s0 12($sp)
	sw	 $ra 8($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	move	 $a0 $s0	# line 24
	sw	 $a0 0($fp)
	lw	 $a0 0($fp)
	jal	 Any.Any
	move	 $a0 $s0	# line 70
	lw	 $fp 16($sp)
	lw	 $s0 12($sp)
	lw	 $ra 8($sp)
	addiu	 $sp $sp 16
	jr	 $ra
IO.is_null:
	addiu	 $sp $sp -16
	sw	 $fp 16($sp)
	sw	 $s0 12($sp)
	sw	 $ra 8($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	lw	 $a0 16($fp)	# line 37
	sw	 $a0 0($fp)
# typecase reg = $a0
	bnez	 $a0 L3	# line 41
	la	 $a0 boolean_lit1	# line 39
	b	 L2
L3:
	lw	 $t1 0($a0)	# line 41
	blt	 $t1 0 L4	# line 40
	bgt	 $t1 9 L4
	la	 $a0 boolean_lit0
	b	 L2
L4:
L1:
	la	 $a1 string_lit2
	li	 $t1 41
	j	 _case_abort
L2:
	lw	 $fp 16($sp)
	lw	 $s0 12($sp)
	lw	 $ra 8($sp)
	addiu	 $sp $sp 20
	jr	 $ra
IO.out_any:
	addiu	 $sp $sp -20
	sw	 $fp 20($sp)
	sw	 $s0 16($sp)
	sw	 $ra 12($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	move	 $a0 $s0	# line 46
	sw	 $a0 0($fp)
	move	 $a0 $s0	# line 45
	sw	 $a0 4($fp)
	lw	 $a0 20($fp)
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 4($fp)
	jal	 IO.is_null
	lw	 $t1 12($a0)
	beqz	 $t1 L5
	la	 $a0 string_lit4
	b	 L6
L5:
	lw	 $a0 20($fp)
	sw	 $a0 4($fp)
	lw	 $a0 4($fp)
	bnez	 $a0 L7
	la	 $a1 string_lit2
	li	 $t1 45
	j	 _dispatch_abort
L7:
	lw	 $t1 8($a0)
	lw	 $t1 4($t1)
	jalr	 $t1
L6:
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 0($fp)	# line 46
	jal	 IO.out
	lw	 $fp 20($sp)
	lw	 $s0 16($sp)
	lw	 $ra 12($sp)
	addiu	 $sp $sp 24
	jr	 $ra
Unit.Unit:
	addiu	 $sp $sp -16
	sw	 $fp 16($sp)
	sw	 $s0 12($sp)
	sw	 $ra 8($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	move	 $a0 $s0	# line 70
	sw	 $a0 0($fp)
	lw	 $a0 0($fp)
	jal	 Any.Any
	move	 $a0 $s0	# line 75
	lw	 $fp 16($sp)
	lw	 $s0 12($sp)
	lw	 $ra 8($sp)
	addiu	 $sp $sp 16
	jr	 $ra
Boolean.toString:
	addiu	 $sp $sp -12
	sw	 $fp 12($sp)
	sw	 $s0 8($sp)
	sw	 $ra 4($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	move	 $a0 $s0	# line 93
	lw	 $t1 12($a0)
	beqz	 $t1 L8
	la	 $a0 string_lit8
	b	 L9
L8:
	la	 $a0 string_lit9
L9:
	lw	 $fp 12($sp)
	lw	 $s0 8($sp)
	lw	 $ra 4($sp)
	addiu	 $sp $sp 12
	jr	 $ra
String.toString:
	addiu	 $sp $sp -12
	sw	 $fp 12($sp)
	sw	 $s0 8($sp)
	sw	 $ra 4($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	move	 $a0 $s0	# line 108
	lw	 $fp 12($sp)
	lw	 $s0 8($sp)
	lw	 $ra 4($sp)
	addiu	 $sp $sp 12
	jr	 $ra
String.length:
	addiu	 $sp $sp -12
	sw	 $fp 12($sp)
	sw	 $s0 8($sp)
	sw	 $ra 4($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	lw	 $a0 12($s0)	# line 114
	lw	 $fp 12($sp)
	lw	 $s0 8($sp)
	lw	 $ra 4($sp)
	addiu	 $sp $sp 12
	jr	 $ra
String.indexOf:
	addiu	 $sp $sp -36
	sw	 $fp 36($sp)
	sw	 $s0 32($sp)
	sw	 $ra 28($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	lw	 $a0 36($fp)	# line 139
	sw	 $a0 0($fp)
	lw	 $a0 0($fp)
	bnez	 $a0 L10
	la	 $a1 string_lit2
	li	 $t1 139
	j	 _dispatch_abort
L10:
	lw	 $t1 8($a0)
	lw	 $t1 16($t1)
	jalr	 $t1
	sw	 $a0 0($fp)
	lw	 $a0 12($s0)	# line 140
	sw	 $a0 4($fp)
	lw	 $a0 0($fp)
	jal	 Any.clone
	lw	 $t1 4($fp)
	lw	 $t1 12($t1)
	lw	 $t2 12($a0)
	sub	 $t1 $t1 $t2
	sw	 $t1 12($a0)
	sw	 $a0 4($fp)
	la	 $a0 int_lit0	# line 141
	sw	 $a0 8($fp)
	la	 $a0 int_lit8	# line 142
	jal	 Any.clone
	lw	 $t1 12($a0)
	neg	 $t1 $t1
	sw	 $t1 12($a0)
	sw	 $a0 12($fp)
	b	 L12	# line 150
L11:
	move	 $a0 $s0	# line 144
	sw	 $a0 16($fp)
	lw	 $a0 8($fp)
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 8($fp)
	sw	 $a0 20($fp)
	lw	 $a0 0($fp)
	jal	 Any.clone
	lw	 $t1 20($fp)
	lw	 $t1 12($t1)
	lw	 $t2 12($a0)
	add	 $t1 $t1 $t2
	sw	 $t1 12($a0)
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 16($fp)
	jal	 String.substring
	sw	 $a0 16($fp)
	lw	 $a0 36($fp)
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 16($fp)
	bnez	 $a0 L15
	la	 $a1 string_lit2
	li	 $t1 144
	j	 _dispatch_abort
L15:
	lw	 $t1 8($a0)
	lw	 $t1 8($t1)
	jalr	 $t1
	lw	 $t1 12($a0)	# line 150
	beqz	 $t1 L13
	lw	 $a0 8($fp)	# line 145
	sw	 $a0 12($fp)
	la	 $a0 unit_lit
	lw	 $a0 4($fp)	# line 146
	sw	 $a0 16($fp)
	la	 $a0 int_lit8	# line 147
	jal	 Any.clone
	lw	 $t1 16($fp)
	lw	 $t1 12($t1)
	lw	 $t2 12($a0)
	add	 $t1 $t1 $t2
	sw	 $t1 12($a0)
	sw	 $a0 8($fp)
	la	 $a0 unit_lit
	b	 L14	# line 150
L13:
	lw	 $a0 8($fp)	# line 148
	sw	 $a0 16($fp)
	la	 $a0 int_lit8	# line 149
	jal	 Any.clone
	lw	 $t1 16($fp)
	lw	 $t1 12($t1)
	lw	 $t2 12($a0)
	add	 $t1 $t1 $t2
	sw	 $t1 12($a0)
	sw	 $a0 8($fp)
	la	 $a0 unit_lit
L14:
L12:
	lw	 $a0 8($fp)	# line 143
	sw	 $a0 16($fp)
	lw	 $a0 4($fp)
	lw	 $t1 16($fp)
	lw	 $t1 12($t1)
	lw	 $t2 12($a0)
	la	 $a0 boolean_lit1
	ble	 $t1 $t2 L16
	la	 $a0 boolean_lit0
L16:
	lw	 $t1 12($a0)	# line 150
	bnez	 $t1 L11
	la	 $a0 unit_lit
	lw	 $a0 12($fp)	# line 152
	lw	 $fp 36($sp)
	lw	 $s0 32($sp)
	lw	 $ra 28($sp)
	addiu	 $sp $sp 40
	jr	 $ra
Symbol.toString:
	addiu	 $sp $sp -16
	sw	 $fp 16($sp)
	sw	 $s0 12($sp)
	sw	 $ra 8($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	la	 $a0 string_lit12	# line 169
	sw	 $a0 0($fp)
	lw	 $a0 16($s0)
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 0($fp)
	jal	 String.concat
	lw	 $fp 16($sp)
	lw	 $s0 12($sp)
	lw	 $ra 8($sp)
	addiu	 $sp $sp 16
	jr	 $ra
Symbol.hashCode:
	addiu	 $sp $sp -12
	sw	 $fp 12($sp)
	sw	 $s0 8($sp)
	sw	 $ra 4($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	lw	 $a0 20($s0)	# line 171
	lw	 $fp 12($sp)
	lw	 $s0 8($sp)
	lw	 $ra 4($sp)
	addiu	 $sp $sp 12
	jr	 $ra
ArrayAny.length:
	addiu	 $sp $sp -12
	sw	 $fp 12($sp)
	sw	 $s0 8($sp)
	sw	 $ra 4($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	lw	 $a0 12($s0)	# line 183
	lw	 $fp 12($sp)
	lw	 $s0 8($sp)
	lw	 $ra 4($sp)
	addiu	 $sp $sp 12
	jr	 $ra
Statistics.Statistics:
	addiu	 $sp $sp -16
	sw	 $fp 16($sp)
	sw	 $s0 12($sp)
	sw	 $ra 8($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	move	 $a0 $s0	# line 209
	sw	 $a0 0($fp)
	lw	 $a0 0($fp)
	jal	 IO.IO
	move	 $a0 $s0	# line 215
	lw	 $fp 16($sp)
	lw	 $s0 12($sp)
	lw	 $ra 8($sp)
	addiu	 $sp $sp 16
	jr	 $ra
Main.Main:
	addiu	 $sp $sp -16
	sw	 $fp 16($sp)
	sw	 $s0 12($sp)
	sw	 $ra 8($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	move	 $a0 $s0	# line 1
	sw	 $a0 0($fp)
	lw	 $a0 0($fp)
	jal	 Any.Any
	move	 $a0 $s0	# line 5
	sw	 $a0 0($fp)
	la	 $a0 int_lit1	# line 4
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 0($fp)	# line 5
	jal	 Main.factorial
	move	 $a0 $s0	# line 12
	lw	 $fp 16($sp)
	lw	 $s0 12($sp)
	lw	 $ra 8($sp)
	addiu	 $sp $sp 16
	jr	 $ra
Main.factorial:
	addiu	 $sp $sp -24
	sw	 $fp 24($sp)
	sw	 $s0 20($sp)
	sw	 $ra 16($sp)
	addiu	 $fp $sp 4
	move	 $s0 $a0
	lw	 $a0 24($fp)	# line 7
	sw	 $a0 0($fp)
	la	 $a0 int_lit0
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 0($fp)
	jal	 Int.equals
	lw	 $t1 12($a0)
	beqz	 $t1 L17
	la	 $a0 int_lit8
	b	 L18
L17:
	lw	 $a0 24($fp)
	sw	 $a0 0($fp)
	move	 $a0 $s0
	sw	 $a0 4($fp)
	lw	 $a0 24($fp)
	sw	 $a0 8($fp)
	la	 $a0 int_lit8
	jal	 Any.clone
	lw	 $t1 8($fp)
	lw	 $t1 12($t1)
	lw	 $t2 12($a0)
	sub	 $t1 $t1 $t2
	sw	 $t1 12($a0)
	sw	 $a0 0($sp)
	addiu	 $sp $sp -4
	lw	 $a0 4($fp)
	jal	 Main.factorial
	jal	 Any.clone
	lw	 $t1 0($fp)
	lw	 $t1 12($t1)
	lw	 $t2 12($a0)
	mulo	 $t1 $t1 $t2
	sw	 $t1 12($a0)
L18:
	lw	 $fp 24($sp)
	lw	 $s0 20($sp)
	lw	 $ra 16($sp)
	addiu	 $sp $sp 28
	jr	 $ra
main:
	jr	 $ra

	.data
	.globl	heap_start
heap_start:
