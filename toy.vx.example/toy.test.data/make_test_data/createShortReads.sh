#!/bin/bash
#Create the short read file with the correct format
rm shortReads.fq*
touch shortReads.fq
for ((i=1;i<=10;i++));
do
   #shuf -n 3 refcopy.fa > short1.fq
   #truncate -s 100 short1.fq
  awk -v n=1 -v s=100  'BEGIN {"date +%N" | getline seed; srand(seed);} 
                          {len=length($0); 
                           for(i=1;i<=n;i++) 
                              {k=rand()*(len-s)+1; printf "%s\t", substr($0,k,s)}
                               print ""}' refnospace.fa > short1.fq   
#awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}\
#' < short1.fq > short1nospace.fq
#   mv short1nospace.fq short1.fq
   tr -d '\040\011\012\015' < short1.fq > short1shorten.fq
   mv short1shorten.fq short1.fq
   echo ">R$i" >> shortReads.fa
   cat short1.fq >> shortReads.fa
   echo "" >> shortReads.fa
   tr "[A-Z]" "\~" < short1.fq > short1_tildas.fq
   echo "@R$i" >> shortReads.fq
   cat short1.fq >> shortReads.fq
   echo "" >> shortReads.fq
   echo "+"  >> shortReads.fq
   cat short1_tildas.fq >> shortReads.fq
   echo "" >> shortReads.fq
done
cp shortReads.fq toy.short_reads.fq
cp shortReads.fa toy.short_reads.fa
mv toy.short_reads.fq ..
mv toy.short_reads.fa ..
cp reference.fa toy.reference.fa
mv toy.reference.fa ..
