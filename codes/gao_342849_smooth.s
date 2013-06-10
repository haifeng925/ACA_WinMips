        .data
; N_COEFFS:  .word   5
; N_SAMPLES: .word   5
; coeff:     .double 0.25 , 0.5 , 1.0 , 0.5 , 0.25
; sample:     .double 1.0,  2.0,  1.0,  2.0, 1.0 
; result:     .double 0,  0,  0,  0,  0
N_COEFFS: .word 5
N_SAMPLES: .word 10
coeff: .double 0.5, 1.0, 1.5, 1.0, 0.5
sample: .double 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
result: .double 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        .text
main: 
        
        ld    r1, N_SAMPLES(r0)
        ld    r2, N_COEFFS(r0)
        slt   r3, r1, r2 ; if N_COEFFS < N_SAMPLES $t3 = 1, else $t3 = 0;
        bnez  r3, exit ; if t3 != 0, jump to printresult
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
        j     cal_result 

else_last_norm1:
        sub.d f3, f0, f3
        add.d f1, f1, f3



cal_result:
        daddu r3, r0, r0            ; i=0
        l.d   f3, sample(r3)
        s.d  f3, result(r3)        ; i=0, result[0] = sample[0]
        daddi r3, r3, 1             ; r3 = 1, i=1
        dsll  r6, r3, 3

        daddi r5, r0, 1             ; j = 1;
        mtc1  r0, f4                ; f4 for temp result

for_within_i_1:
        slt   r7, r5, r4
        beqz  r7, calculate_with_norm2
        dsub  r8, r5, r3            
        dsll  r8, r8, 3             ;&sample[i-2+j] sample[j-1]
        dsll  r9, r5, 3             ;&coeff[j]
        l.d   f5, sample(r8)
        l.d   f6, coeff(r9)
        mul.d f7, f5, f6
        add.d f4, f4, f7
        daddi r5, r5, 1
        j     for_within_i_1
calculate_with_norm2:
        div.d f4, f4, f2            ; result[1]/=norm2
        s.d  f4, result(r6)
        daddi r3, r3, 1             ; r3 = 2 = i

        ;; for n: 2 -> n-2

        dsub r6, r1, r3             ; r6 = N_SAMPLES - 2
normal_result:
        slt  r7, r3, r6             ; r3=i
        beqz r7, last_two_result

        mtc1 r0, f4                 ; f4 for temp result
        daddu r5, r0, r0            ; r5 = j = 0
for_within_normal:
        slt  r7, r5, r2             ; r2 = N_COEFFS
        beqz r7, calcu_with_norm1
        daddi r8, r0, 2
        dsub  r9, r3, r8
        daddu r9, r9, r5            ; r9 = i-2+j
        dsll  r9, r9, 3
        dsll  r10, r5, 3
        l.d   f5, sample(r9)
        l.d   f6, coeff(r10)
        mul.d f7, f5, f6
        add.d  f4, f4, f7
        daddi r5, r5, 1
        j     for_within_normal

calcu_with_norm1:
        div.d f4, f4, f1
        dsll  r11, r3, 3
        s.d  f4, result(r11)
        daddi r3, r3, 1
        j     normal_result

last_two_result:                    ; i= n-2
        mtc1  r0, f4                 ; f4 for temp result
     ;   daddi r6, r3, 3              

        daddi r5, r0, 1             ; j=1
for_with_last_second:
        slt   r7, r5, r4             ;r4 N_COEFFS -1
        beqz  r7, cal_last_second
        daddi r8, r0, 2
        dsub  r9, r3, r8
        daddu r9, r9, r5
        dsll  r9, r9, 3
        dsll  r10, r5, 3
        l.d   f5, sample(r9)
        l.d   f6, coeff(r10)
        mul.d f7, f5, f6
        add.d f4, f4, f7
        daddi  r5, r5, 1
        j     for_with_last_second
cal_last_second:
        div.d f4, f4, f2
        dsll  r11, r3, 3
        s.d  f4, result(r11)
        daddi r3, r3, 1

        dsll  r11, r3, 3
        l.d   f3, sample(r11)
        s.d  f3, result(r11)
exit:
       halt