#!/bin/bash
bwa index reference.fasta
bwa mem reference.fasta reads.toy.example.fastq | samtools view -bS - > reads.toy.example.bwa.bam
