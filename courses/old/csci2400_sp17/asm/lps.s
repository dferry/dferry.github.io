#compile with gcc -m32 loops.s -o loops

#Declare program code section of program
.text
.global main                            /* program entry point */


main:
	#Preamble to the main function
	pushl	%ebp
	movl	%esp, %ebp

	#Our code starts here

	movl	$0, %ecx
	leal	array, %edx
	TOP:
	#pusha
	#pushl	(%edx, %ecx, 4)
	#pushl	%ecx
	#pushl	$loopstr
	#call	printf
	#pop	%eax
	#pop	%eax
	#pop	%eax
	#popa
	
	movl	(%edx, %ecx, 4), %eax
	cmpl	target,	%eax
	je	FOUND	

	incl	%ecx
	cmpl	length, %ecx
	jne	TOP
	jmp	NOFOUND
	
	FOUND:
	pusha
	pushl	%eax
	pushl	%ecx
	pushl	$loopstr
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	popa

	NOFOUND:

	#Our code ends here

	#Finish the main function with leave and ret
	EXIT:
	leave
	ret

print_all:
	pushl	%ebp
	movl	%esp, %ebp
	call	print_intro
	call	print_eax
	call	print_ebx
	call	print_ecx
	call	print_edx
	call	print_cf
	call	print_zf
	call	print_sf
	call	print_of
	leave
	ret

print_intro:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%eax
	pushl	%ecx
	pushl	%edx
	pushl	$intro
	call	printf
	pop	%eax
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	leave
	ret

print_eax:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%ecx
	pushl	%edx
	pushl 	%eax
	pushl	$streax
	pushl	$string
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%edx
	pop	%ecx
	popf
	leave
	ret

print_ebx:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	pushl 	%ebx
	pushl	$strebx
	pushl	$string
	call	printf
	pop	%ebx
	pop	%ebx
	pop	%ebx
	pop	%eax
	pop	%edx
	pop	%ecx
	popf
	leave
	ret

print_ecx:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%edx
	pushl	%eax
	pushl 	%ecx
	pushl	$strecx
	pushl	$string
	call	printf
	pop	%ecx
	pop	%ecx
	pop	%ecx
	pop	%eax
	pop	%edx
	popf
	leave
	ret

print_edx:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%ecx
	pushl	%eax
	pushl 	%edx
	pushl	$stredx
	pushl	$string
	call	printf
	pop	%edx
	pop	%edx
	pop	%edx
	pop	%eax
	pop	%ecx
	popf
	leave
	ret

print_cf:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx
	pushf	#push eflags onto stack
	pop	%eax #move flags from stack to reister
	andl	$0x1, %eax #select first bit of flags
	pushl	%eax #push that value onto the stack
	pushl	$strcf
	pushl	$string
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	leave
	ret

print_zf:
	#function preamble
	pushl	%ebp
	movl	%esp, %ebp
	#save processor state
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx

	#Now we select the seventh bit and move it to the first place
	pushf	#push eflags onto stack
	pop	%eax #put eflags into register
	andl	$0x40, %eax #select seventh bit of flags
	shrl	$6, %eax #move the seventh bit down to the first place

	#Set up and call printf function
	pushl	%eax #push the 0/1 value onto the stack for printf
	pushl	$strzf #push the zf string onto stack for printf
	pushl	$string #push the specifier string onto stack for printf
	call	printf
	pop	%eax #clear $string from stack
	pop	%eax #clear $strzf from stack
	pop	%eax #clear the 0/1 value from the stack

	#restore processor state
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	#function exit
	leave
	ret


print_sf:
	#function preamble
	pushl	%ebp
	movl	%esp, %ebp
	#save the existing state of the processor
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx

	#Finish this function by writing your code here
	#Now we select the eighth bit and move it to the first place
        pushf   #push eflags onto stack
        pop     %eax #put eflags into register
        andl    $0x80, %eax #select eigth bit of flags
        shrl    $7, %eax #move the eigth bit down to the first place

        #Set up and call printf function
        pushl   %eax #push the 0/1 value onto the stack for printf
        pushl   $strsf #push the zf string onto stack for printf
        pushl   $string #push the specifier string onto stack for printf
        call    printf
        pop     %eax #clear $string from stack
        pop     %eax #clear $strzf from stack
        pop     %eax #clear the 0/1 value from the stack

	#restore the existing state of the processor
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	#Function exit code
	leave
	ret

print_of:
	pushl	%ebp
	movl	%esp, %ebp
	pushf
	pushl	%eax
	pushl	%ecx
	pushl 	%edx
	pushf	#push eflags onto stack
	pop	%eax #move eflags from stack to register
	andl	$0x800, %eax #select twelfth bit of flags
	shrl	$11,	%eax #move place 12 to place 1
	pushl	%eax #push that value onto the stack
	pushl	$strof
	pushl	$string
	call	printf
	pop	%eax
	pop	%eax
	pop	%eax
	pop	%edx
	pop	%ecx
	pop	%eax
	popf
	leave
	ret

#Declare read-only data section of program
.section	.rodata
    string:
	.string "Value of %s: %d\n"
    streax:
	.string	"EAX"
    strebx:
	.string	"EBX"
    strecx:
	.string	"ECX"
    stredx:
	.string	"EDX"
    strcf:
	.string "Carry Flag"
    strzf:
	.string "Zero Flag"
    strsf:
	.string "Sign Flag"
    strof:
	.string "Overflow Flag"
    intro:
	.string "Printing processor state:\n"
    zfone:
	.string "Result is FALSE\n"
    zfzero:
	.string "Result is TRUE\n"
    loopstr:
	.string "Loop iter %d has value %d\n"

#Declare read/write data section of program
.section .data
    target:
	.long   615049950
    length:
	.long	500
    array:
	.long	-360061235
	.long	-62349825
	.long	-33196574
	.long	-633748002
	.long	-187706348
	.long	-737123734
	.long	209096230
	.long	-214907477
	.long	634416944
	.long	-916933463
	.long	-198921557
	.long	-315639058
	.long	-53653488
	.long	602389930
	.long	-859046051
	.long	-619873762
	.long	-398470834
	.long	617710119
	.long	-922756749
	.long	-831937264
	.long	-321771279
	.long	425459979
	.long	-363740022
	.long	-588409563
	.long	760252946
	.long	-634098649
	.long	38025012
	.long	799680466
	.long	-810615127
	.long	-528825599
	.long	540712665
	.long	258708435
	.long	490184874
	.long	-466468514
	.long	637402235
	.long	505746004
	.long	899664503
	.long	729583665
	.long	453061684
	.long	425881402
	.long	944611786
	.long	301967063
	.long	-434101683
	.long	-673217876
	.long	978231631
	.long	-616210855
	.long	326479061
	.long	32175009
	.long	-317280513
	.long	-975947128
	.long	-129390475
	.long	-66650553
	.long	314633517
	.long	-586663757
	.long	769618084
	.long	-980313468
	.long	-333171019
	.long	891312384
	.long	-19657364
	.long	-170964397
	.long	668287796
	.long	-68760994
	.long	150051630
	.long	-137583358
	.long	-298450021
	.long	-482727177
	.long	978467153
	.long	87443245
	.long	-486239931
	.long	-754878181
	.long	461833735
	.long	813685945
	.long	886899099
	.long	-452168525
	.long	-815583313
	.long	161782181
	.long	638936992
	.long	-712571300
	.long	699506556
	.long	-480945963
	.long	400237612
	.long	-123133705
	.long	123114862
	.long	-484818237
	.long	56463887
	.long	-570984128
	.long	-299450263
	.long	793707424
	.long	-97081472
	.long	-652612063
	.long	-812336066
	.long	127192881
	.long	-741010647
	.long	942417665
	.long	-394421246
	.long	-360390233
	.long	309187115
	.long	-563602696
	.long	-525233332
	.long	-427125689
	.long	-399129283
	.long	648534607
	.long	516344188
	.long	565426952
	.long	-810262666
	.long	-414278628
	.long	262501976
	.long	-538615517
	.long	-992234369
	.long	208484603
	.long	-641975887
	.long	31677975
	.long	24342288
	.long	-25583955
	.long	-876011313
	.long	282848902
	.long	609550053
	.long	-789380972
	.long	-857559460
	.long	-202421144
	.long	-659307583
	.long	-722863251
	.long	-461739178
	.long	911095485
	.long	377510910
	.long	132118720
	.long	-6879483
	.long	-322702743
	.long	20966065
	.long	806445199
	.long	967981459
	.long	117095547
	.long	855634704
	.long	-841127219
	.long	56668896
	.long	112671803
	.long	51097641
	.long	589453142
	.long	728006229
	.long	-501764547
	.long	-496709374
	.long	974044012
	.long	-773917091
	.long	-838306744
	.long	-177226343
	.long	-804476126
	.long	-665924696
	.long	347108293
	.long	525444156
	.long	-500833816
	.long	-492898398
	.long	-467858925
	.long	752037047
	.long	-102518684
	.long	-884842188
	.long	-12309181
	.long	343802960
	.long	795631868
	.long	-109366700
	.long	345460890
	.long	899857497
	.long	-617576708
	.long	742727187
	.long	-613914184
	.long	-246879389
	.long	796696
	.long	869439338
	.long	-581987388
	.long	-8850013
	.long	-434037662
	.long	366781191
	.long	232639300
	.long	-345039047
	.long	-928797004
	.long	91440880
	.long	-345262861
	.long	-853125478
	.long	114043816
	.long	18222954
	.long	-327647146
	.long	412696797
	.long	896808497
	.long	976504346
	.long	167867668
	.long	-331961168
	.long	494908018
	.long	-882161217
	.long	-955175806
	.long	-454847808
	.long	-527078064
	.long	-56357962
	.long	-472775183
	.long	-412942451
	.long	440910661
	.long	512667701
	.long	30071228
	.long	657335630
	.long	610419400
	.long	366029873
	.long	-764115983
	.long	-456715666
	.long	-925053020
	.long	567011516
	.long	-904375871
	.long	971452555
	.long	684063190
	.long	-934914621
	.long	114094918
	.long	-237339113
	.long	-60737672
	.long	346280908
	.long	-957400309
	.long	953324597
	.long	745387933
	.long	-442643668
	.long	-6255664
	.long	639535931
	.long	-848620432
	.long	-137633917
	.long	-387917110
	.long	193312498
	.long	288758726
	.long	-867161797
	.long	-240414383
	.long	-343953132
	.long	725632727
	.long	-657198443
	.long	-375261523
	.long	618639705
	.long	138835212
	.long	911665256
	.long	941640618
	.long	-14142708
	.long	79418700
	.long	548765398
	.long	-513260673
	.long	429529458
	.long	218349325
	.long	545489141
	.long	486708012
	.long	-765404257
	.long	-600102094
	.long	-411099545
	.long	862640337
	.long	159395583
	.long	633510482
	.long	435035265
	.long	652271374
	.long	926032878
	.long	54983485
	.long	-760605269
	.long	73520400
	.long	958097553
	.long	-463134542
	.long	684242465
	.long	-295409043
	.long	938640303
	.long	318116721
	.long	318346142
	.long	379283194
	.long	-777241962
	.long	79827972
	.long	34898815
	.long	-980657823
	.long	-150137762
	.long	-41059675
	.long	656978428
	.long	-218419687
	.long	-414796050
	.long	549308547
	.long	-370286824
	.long	-385100110
	.long	490001992
	.long	-154088381
	.long	-820707744
	.long	755640634
	.long	-321437566
	.long	-650283410
	.long	69075391
	.long	144868544
	.long	634755342
	.long	-982437451
	.long	-505924886
	.long	-578946244
	.long	10233698
	.long	-170100887
	.long	-573119285
	.long	838463052
	.long	-979786804
	.long	-652025925
	.long	490950123
	.long	978079222
	.long	-194871188
	.long	761967312
	.long	320317796
	.long	571348854
	.long	-507068481
	.long	-797636592
	.long	390141476
	.long	-487406492
	.long	-363634736
	.long	453942644
	.long	167315742
	.long	-394541222
	.long	735283799
	.long	988027343
	.long	796480791
	.long	440677960
	.long	-95549556
	.long	501037688
	.long	775399076
	.long	-934549661
	.long	570931095
	.long	22344021
	.long	485506523
	.long	972672038
	.long	-744790394
	.long	871533624
	.long	763626793
	.long	822544327
	.long	58147105
	.long	969212697
	.long	502620564
	.long	-444873730
	.long	-260558500
	.long	-221424467
	.long	47540292
	.long	386588626
	.long	-508101472
	.long	-589717051
	.long	613695279
	.long	848928989
	.long	-506713584
	.long	-426109017
	.long	-722769420
	.long	183560387
	.long	-131613546
	.long	-515565049
	.long	-565688569
	.long	-155849109
	.long	-422055400
	.long	712109215
	.long	531083750
	.long	747327144
	.long	946986309
	.long	-332254204
	.long	-714994184
	.long	975831674
	.long	-609703998
	.long	-520245866
	.long	700039861
	.long	-889028535
	.long	-213452212
	.long	643287100
	.long	-488945267
	.long	229050595
	.long	236249968
	.long	-383536112
	.long	896871827
	.long	877907548
	.long	-532013713
	.long	540653392
	.long	615049950
	.long	-611645185
	.long	-797229097
	.long	924548485
	.long	713588215
	.long	-83493281
	.long	-783688621
	.long	484308382
	.long	179106574
	.long	31700708
	.long	181158062
	.long	214530188
	.long	-895238694
	.long	712084202
	.long	-287966415
	.long	208380059
	.long	688755132
	.long	299543042
	.long	-105304605
	.long	-992619244
	.long	-230238307
	.long	-913695076
	.long	843266970
	.long	-851910377
	.long	-79532500
	.long	-851488214
	.long	558277024
	.long	-241164546
	.long	-816471348
	.long	658234967
	.long	-167660266
	.long	673323926
	.long	-323409453
	.long	-320576136
	.long	609734889
	.long	55158135
	.long	-29707849
	.long	756482598
	.long	398193022
	.long	330325649
	.long	905657911
	.long	-724558206
	.long	607400529
	.long	833588293
	.long	-144372764
	.long	-311287879
	.long	296300897
	.long	-462690465
	.long	123535798
	.long	852706170
	.long	-856653826
	.long	-829644949
	.long	811525585
	.long	-338448819
	.long	140334888
	.long	-842312058
	.long	163440668
	.long	-662458661
	.long	664149825
	.long	190536817
	.long	478878247
	.long	-687261749
	.long	-131370967
	.long	-24583238
	.long	-340453772
	.long	94236136
	.long	-563108848
	.long	-714387186
	.long	-686419484
	.long	453948601
	.long	-215248731
	.long	104080374
	.long	933071034
	.long	-337211249
	.long	-402658500
	.long	-928428824
	.long	-899527107
	.long	-842355031
	.long	-476448548
	.long	519962805
	.long	494184342
	.long	-219833665
	.long	-882146892
	.long	560367983
	.long	850365384
	.long	180287354
	.long	-901007202
	.long	-157074838
	.long	809907401
	.long	167410567
	.long	-409317247
	.long	-709358969
	.long	-552552650
	.long	817684739
	.long	675324914
	.long	716526200
	.long	115444023
	.long	985693379
	.long	252481071
	.long	720150700
	.long	712699101
	.long	334348951
	.long	-801877354
	.long	623021736
	.long	383201471
	.long	-882786866
	.long	-684123856
	.long	-552118630
	.long	357281501
	.long	706529134
	.long	273727418
	.long	-239849105
	.long	-77122673
	.long	-317709664
	.long	972119851
	.long	-345824554
	.long	-341933862
	.long	48052604
	.long	96324414
	.long	-658462775
	.long	731630765
	.long	-431375524
	.long	519184983
	.long	299309932
	.long	413080231
	.long	307878243
	.long	-323341136
 	.long	869478689
	.long	-480435496
	.long	515520581
	.long	-406486332
	.long	550629968
	.long	-529073006
	.long	960508402
	.long	-203380512
	.long	694330904
	.long	379246794
	.long	479181290
