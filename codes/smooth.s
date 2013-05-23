        .data
N_COEFFS:  .word   5
; coeff:     .double 0.25 , 0.5 , 1.0 , 0.5 , 0.25
N_SAMPLES: .word   5
result: .word 0
; sample:    .double 1.0 , 2.0 , 1.0 , 2.0 , 1.0
; result:    .double 0.0 , 0.0 , 0.0 , 0.0 , 0.0

        .text
main: 
        ld $t1, N_SAMPLES(r0)
        ld $t2, N_COEFFS(r0)
      ;  slt r5, r4, r3 ; if N_COEFFS < N_SAMPLES $t2 = 1, else $t2 = 0;
      ;  bnez r5, printresult ; if t2 != 0, jump to printresult
        dsub $t3, $t1, $t2
        sd $t3, result(r0)
        halt
        ; bltz r5, printresult
; smooth: 
        

; printresult:
;          j Exit
; Exit:
;         halt

