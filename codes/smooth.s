        .data
N_COEFFS:  .word   5
coeff:     .double 0.25 , 0.5 , 1.0 , 0.5 , 0.25
N_SAMPLES: .word   5

; sample:    .double 1.0 , 2.0 , 1.0 , 2.0 , 1.0
; result:    .double 0.0 , 0.0 , 0.0 , 0.0 , 0.0
 list:   .word 15, 0, 1, 2, 6, -2, 4, 7, 3, 7
 listxx:   .word 5, 0, 1, 2, 6, -2, 4, 7, 3, 7

        .text
main: 
       
        ld $t5, listxx(r0)
        ld $t1, N_SAMPLES(r0)
        ld $t2, N_COEFFS(r0)
      ;  slt r5, r4, r3 ; if N_COEFFS < N_SAMPLES $t2 = 1, else $t2 = 0;
      ;  bnez r5, printresult ; if t2 != 0, jump to printresult
        dsub $t3, $t1, $t2
        ;sd $t3, result(r0)
        
        daddi r1, r0, 0
        ld r2, list(r1); load arrays
        daddi r1, r1, 8
        ld r2, list(r1)
        daddi r1, r1, 8
        ld r2, list(r1)
        daddi r1, r1, 8
        ld r2, list(r1)
        halt
        ; bltz r5, printresult
; smooth: 
        

; printresult:
;          j Exit
; Exit:
;         halt

