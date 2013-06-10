        .data
N_COEFFS:  .word   5
N_SAMPLES: .word   5
coeff:     .double 0.25 , 0.5 , 1.0 , 0.5 , 0.25
sample:     .double 1.0,  2.0,  1.0,  2.0, 1.0 
result:     .double 0,  0,  0,  0,  0
norm1:      .double 0
norm2:      .double 0
d_zero:     .double 0.0

        .text
main: 
        ld    r1, N_SAMPLES(r0)
        ld    r2, N_COEFFS(r0)
        slt   r3, r2, r1 ; if N_COEFFS < N_SAMPLES $t3 = 1, else $t3 = 0;
        bnez  r3, printresult ; if t3 != 0, jump to printresult
        
        mtc1  r0, f1                ;norm1
        mtc1  r0, f2                ;norm2
 
        daddi r3, r0, 1             ;i=1
        dsub  r4, r2, r3            ;r4 = N_COEFFS-1 
        mtc1  r0, f0                ; move r0 to f0=0;

for_norm2:
        slt   r5, r3, r4
        beqz  r5, norm1        ;if i<N_COEFFS-1, jump to norm1_left
        dsll  r6, r3, 3             ; i*8
        l.d   f3, coeff(r6)         ; f3 = coeff[i]
        c.lt.d f3, f0
        bc1t  n2_negativ_coeff 
        add.d f2, f2, f3          
        daddi r3, r3, 1            ;i++
        j     for_norm2

n2_negativ_coeff:
        sub.d f3, f0, f3
        add.d f2, f2, f3
        daddi r3, r3, 1
        j     for_norm2


norm1:
        l.d   f3, coeff(r0)
        c.lt.d  f3, f0
        bc1t  else_norm1
        add.d  f1, f2, f3
        j     last_norm1
else_norm1:
        sub.d f3, f0, f3
        add.d f1, f2, f3

last_norm1:
        dsll  r6, r3, 3
        l.d   f3, coeff(r6)
        c.lt.d  f3, f0
        bc1t  else_last_norm1
        add.d f1, f1, f3
        j     result 

else_last_norm1:
        sub.d f3, f0, f3
        add.d f1, f1, f3

result:

printresult:
    halt