; Autor reseni: Thu Tra Phamová - xphamo00

; Projekt 2 - INP 2022
; Vernamova sifra na architekture MIPS64

; DATA SEGMENT
                .data
login:          .asciiz "xphamo00"  ; sem doplnte vas login
cipher:         .space  17  ; misto pro zapis sifrovaneho loginu

params_sys5:    .space  8   ; misto pro ulozeni adresy pocatku
                            ; retezce pro vypis pomoci syscall 5
                            ; (viz nize "funkce" print_string)

; CODE SEGMENT
                .text
                ; ZDE NAHRADTE KOD VASIM RESENIM
                
                ; registers to use: xphamo00-r19-r2-r12-r26-r0-r4
main:
                                                ; r0 is for "fixed" zero
                daddi r2, r0, 0                 ; r2 is for 'dsub' since it doesnt accept immediate
                daddi r4, r0, 0                 ; r4 is used as counter
                daddi r12, r0, 0                ; r12 is for comparison
                daddi r19, r0, 0                ; r19 is for encrypting the letters one by one
                daddi r26, r0, 0                ; r26 is used as counter to know the position in login
checkNumber:
                lb r19, login(r26)              ; r19 = login[0], load from login to r19
                slti r12, r19, 97               ; if (r19 < 97) then r12 = 1 else r12 = 0
                bne r12, r0, finish             ; r12 != 0 --> jump to finish

                beq r4, r0, plus                ; r4 == 0 --> jump to plus
                b minus                         ; jumps to minus (r4 == 1)
plus:
                daddi r4, r0, 1                 ; r4 = 1

                daddi r19, r19, 16              ; adds up '?' +  16 ('p')
                slti r12, r19, 123              ; if (r19 < 123) then r12 = 1 else r12 = 0
                beq r12, r0, fixingPlus         ; r12 == 0 --> jump to fixingPlus
                b loadCipherPlus
fixingPlus:
                daddi r2, r0, 122               ; r2 used when necessary
                dsub r19, r19, r2               ; r19 = r19 - 'z' (122)
                daddi r19, r19, 96              ; r19 = r19 + 'ascii code before letter a'
loadCipherPlus:
                sb r19, cipher(r26)             ; cipher[?] = '?'  - saves new letter in cipher
                daddi r26, r26, 1               ; r26++  - counter for next letter in login to load
                b checkNumber
minus:
                daddi r4, r0, 0                 ; r4 = 0

                daddi r2, r0, 8                 ; r2 = 8 ('h')
                dsub r19, r19, r2               ; r19 = '?' - 8 ('h')
                slti r12, r19, 97               ; if (r19 < 97) then r12 = 1 else r12 = 0
                bne r12, r0, fixingMin          ; r12 != 0 --> jump to fixingMin
                b loadCipherMinus
fixingMin:
                daddi r2, r0, 96
                dsub r19, r19, r2               ; r19 = r19 - 'ascii code before letter a'
                daddi r19, r19, 122             ; r19 = r19 + 'z' (122)
loadCipherMinus:
                sb r19, cipher(r26)             ; cipher[?] = '?'  - saves new letter in cipher
                daddi r26, r26, 1               ; r26++  - counter for next letter in login to load
                b checkNumber
finish:
                daddi r4 , r0, 0                ; clears r4

                daddi   r4, r0, cipher          ; r4 = cipher
                jal     print_string            ; vypis pomoci print_string - viz nize

                syscall 0                       ; halt

print_string:                                   ;; adresa retezce se ocekava v r4
                sw      r4, params_sys5(r0)
                daddi   r14, r0, params_sys5    ; adr pro syscall 5 musi do r14
                syscall 5                       ; systemova procedura - vypis retezce na terminal
                jr      r31                     ; return - r31 je urcen na return address
