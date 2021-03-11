#Data Compression (45 points): Write a MIPS assembly program in the MARS simulator that accepts an input string of size less than 40 characters, and applies the following compression algorithm to the string, and then prints the resulting compressed string. The input string will only consist of alphabets, i.e., a-z and A-Z. First check the string to make sure it's a valid input (if not, print an error message and quit). Then walk through the string looking for consecutive occurrences of the same character and replace them with the character and a count (called a "run length encoding"). For example, if you see AAAAA, you would replace them with A5. If you see BBBBBBBBBBBB, you would replace them with B12. Note that the number 12 is represented as characters "1" and "2" within the output string. Single character occurrences do not need a count. For reference, here is an ASCII table. Here is an example run of the program:
#Provide an input string with less than 40 characters and only containing a-z or A-Z:
#AACCCCCGTTTTTTTTTTTTTTAAAabbcd
#The compressed string is:
#A2C5GT14A3ab2cd

#The c program for the given question can be written as:
##include<stdio.h>
#include<string.h>

#int main(){
#    char a[20];
#    scanf("%s", &a);
#    int i=0, k=0;
#    int count[20];
#    char ch[20],z;
#    for(i=0;i<20;i++){
#        count[i]=0;
#        ch[i]=0;
#    }
#    for(i=0;i<strlen(a);i++){
#        z=a[i];
#        int j;
#        while(1){
#            j=i+1;
#            count[k]+=1;
#            ch[k]=z;
#            if(a[j]==z){
#                //count[k]+=1;
#                //ch[k]=z;
#                i++;
#            }
#            else{
#                // count[k]+=1;
#                // ch[k]=z;
#                break;
#            }
#        }
#        k++;
#   }
#    for(i=0;i<strlen(ch);i++)
#    printf("%c %d ", ch[i], count[i]);
#    return 0;
#}


#This code is contributed by Khushi Shukla
.data
    msg1: .asciiz "Enter the string(less than 40 characters): "
    str1: .space 40
    count: .space 40
    chname: .space 40
    msg2: .asciiz "\nThe compressed string is: "
    msg3: .asciiz "\nInvalid input\n"
    msg4: .asciiz "\nThe string should be less than 40 characters\n"
    space: .asciiz " "

.text

    #The functions used in the code are:
    #1. strlen: to calculate the length of the string
    #2. validationCheck: to check if the string is valid. It is invalid if it contains any numeric or special characters
    #3. strCompress: The function that performs the compression of the string
    #4. printValues: The function that prints the compressed string

    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 8
    la $a0, str1
    li $a1, 91
    syscall

    la $a0, str1 #string to be operated is in a0
    addi $a1, $zero, 0 #size of string
    jal strlen
    
    move $s1, $v0#size of string
    
    bgt $s1, 40, morethan39

    jal validationCheck
    
    #initializing the count and chname arrays with 0
    li $t0, 0
    addi $t0, $zero, 0
    while:
        bge $t0, 40, exit
        sb $zero, count($t0) #initializing count[] ={0}
        sb $zero, chname($t0) #initializing chname[] ={0}
        addi $t0, $t0, 4 #i++
        j while
    exit:
    
    #calling the function to compress the string
    jal strCompress
    
    #printing the compressed string
    jal printValues
    li $v0,10
    syscall
    
    
    #function to calculate the string length
    strlen: 
        lb $t0, 0($a0)
        beqz $t0, out
        addi $a1, $a1, 1
        addi $a0, $a0, 1
        j strlen
    out:
        move $v0, $a1
        jr $ra
    
            
    validationCheck:
        li $t1, 0 #to keep track of the size of the string
        li $t0, -1
        check:
            addi $t1, $t1, 1
            addi $t0, $t0,1
            bge $t1, $s1,next
            bge $t0, $s1, next
            
            lb $t2, str1($t0)
            
            ble $t2, 64, breaking
            
            bge $t2, 91, interval
            
            j check
    
        interval:
            ble $t2, 96, breaking
            bge $t2, 123, breaking
            j check
        next:
            jr $ra
        
    strCompress:  
        addi $t0, $zero, -1 #i =-1 as incrementing of i is done below
 
        addi $t2, $zero, 0#t2=k
    
        else:
            addi $t2, $t2, 1 #k++
            addi $t0, $t0, 1 #i++
        
        while1: 
            bgt $t0, 40, exit1
            lb $s1, str1($t0) # z=a[i]
        
        while3:
            addi $t1, $t0, 1 #j=i+1
            lb $t3, str1($t1) #t3=a[j]
            lb $t4, count($t2) #t4=count[k]
            addi $t4, $t4, 1 #count[k]+=1
            sb $t4, count($t2) #count[k]+=1
            sb $s1, chname($t2) #ch[k]=z
        
            bne $t3, $s1, else
            addi $t0, $t0, 1 #i++
        
            j while3
              
        exit1:
            jr $ra
    
    printValues:    
        addi $t0, $zero, 1
        la $a0, msg2
        li $v0, 4
        syscall

        print:
            bge $t0, 40, exiting
        
            lb $a0, chname($t0)
            ble $a0, 64, exiting
            li $v0, 11
            syscall
        
            lb $a0, count($t0)
            beq $a0, 1, spacing #if character is present once no need to print 1 with it
            li $v0, 1 
            syscall

        spacing:
            li $v0, 4
            la $a0, space
            syscall
            addi $t0, $t0, 1
        
            j print

        exiting:
            jr $ra
    
    morethan39:
        la $a0, msg4
        li $v0, 4
        syscall
               
    breaking:
        la $a0, msg3
        li $v0, 4
        syscall
    
