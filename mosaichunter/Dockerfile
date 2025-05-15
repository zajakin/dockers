FROM anabuurs/mosaichunter
# FROM debian:testing-slim
# docker run -it debian:testing-slim bash
RUN apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates && mkdir MosaicHunter/resources && \
    wget https://mosaichunter.cbi.pku.edu.cn/download/human_g1k_v37.fasta.gz -O resources/human_g1k_v37.fasta.gz && \
    wget https://mosaichunter.cbi.pku.edu.cn/download/dbsnp_137.b37.tsv.gz -O resources/dbsnp_137.b37.tsv.gz

    # docker pull anabuurs/mosaichunter
    # docker run -it anabuurs/mosaichunter
  
#     apt update && apt install --no-install-recommends bash-completion ant git mc wget libpng-tools libpng-dev make gcc
# 
#    git clone https://github.com/djhshih/blat.git
#    cd blat
#    make
# 
#    wget http://users.soe.ucsc.edu/~kent/src/blatSrc35.zip
#    unzip blatSrc35.zip
#    cd blatSrc/
# $ cp $LIBPNGDIR/png.h lib/
# $ cp $LIBPNGDIR/pngconf.h lib/
# $ cp $LIBPNGDIR/pnglibconf.h lib/
#    echo $MACHTYPE # It will display the OS and hardware. For example, ‘x86_64-ubuntu-linux-gnu’.
# $ MACHTYPE=x86_64
# $ export MACHTYPE
# $ mkdir -p ~/bin/$MACHTYPE
# $ make


#    git clone https://github.com/zzhang526/MosaicHunter.git
#     mkdir resources
#     wget https://mosaichunter.cbi.pku.edu.cn/download/human_g1k_v37.fasta.gz -O resources/human_g1k_v37.fasta.gz
#     wget https://mosaichunter.cbi.pku.edu.cn/download/dbsnp_137.b37.tsv.gz -O resources/dbsnp_137.b37.tsv.gz
#  cd MosaicHunter
#    ant
# # The newly compiled mosaichunter.jar file will overwrite the pre-compiled one in build/ directory, and you can run MosaicHunter with:
#    java -jar build/mosaichunter.jar

# In addition, we suggest to only keep proper-mapped reads (for paired-end reads; with flag 0x2), and drop reads with NM > 4, to make the input cleaner. The command to achieve this is as follows:
#    samtools view -h -f 0x2 input.bam | perl -ne 'print if (/^@/||(/NM:i:(\d+)/&&$1cleaner.bam
#    Preparing sample-specific files:
# False mosaic sites can be caused by alignment errors in the genomic regions containing INDELs and CNVs, thus we suggest that you generate a list of such error-prone regions for MosaicHunter to mask. 
# We recommend to identify and filter INDELs and CNVs from the processed .bam file following the pipelines of GATK and CNVnator, respectively. 
# The regions of called INDELs (with +/-5bp flanks) and CNVs should be then converted to the .bed format and specify the corresponding parameter indel_region_filter.bed_file when running MosaicHunter.

# The standard command-line usage of MosaicHunter is
#    java -jar your_path/build/mosaichunter.jar -P param_1=value_1 [-P param_2=value_2 [...]]
# (Note: predefined_configuration could be 'genome', 'exome', or 'exome_parameters'.)
# or
#    java -jar your_path/build/mosaichunter.jar -C -P param_1=value_1 [-P param_2=value_2 [...]]

The output files will be put into the path set by the top parameter output_dir.
We provided demo files in your_path/MosaicHunter/demo to show how to run MosaicHunter. The command to run the demo is

   cd your_path/MosaicHunter/

   java -jar build/mosaichunter.jar genome \
   -P input_file=demo/demo_sample.bam \
   -P reference_file=demo/hg37_chr18.fa \
   -P mosaic_filter.sex=M \
   -P mosaic_filter.dbsnp_file=demo/dbsnp137_hg37_chr18_demo.tsv \
   -P repetitive_region_filter.bed_file=resources/all_repeats.b37.bed \
   -P indel_region_filter.bed_file=demo/demo_sample.indel_CNV.bed \
   -P common_site_filter.bed_file=resources/WGS.error_prone.b37.bed \
   -P output_dir=demo_output

# You can find the final passed list in demo_output/final.passed.tsv, which should contain only one row for the candidate SNM site of 18:70512197.

# Output format:
# All of the output files are in the specified directory output_dir, including the final candidate list final.passed.tsv, the filtered and remained remaining variant lists of each filters (.filtered.tsv, .passed.tsv), and other temporary files, such as blat input and output.
# The final.passed.tsv files are in tab-separated format, whose columns' meanings for single mode are listed below:
# Contig / chromosome name
# 1. Contig / chromosome name
# 2. Position / coordinate on the contig (1-based)
# 3. Base of reference allele
# 4. Total depth of this site
# 5. Pileuped sequencing bases at this site
# 6. Pileuped sequencing baseQs at this site
# 7. Base of major allele
# 8. Depth of major allele
# 9. Base of minor allele
# 10. Depth of minor allele
# 11. dbSNP allele frequency of major and minor alleles
# 12. log10 prior probability of major-homozygous genotype
# 13. log10 prior probability of heterozygous genotype
# 14. log10 prior probability of minor-homozygous genotype
# 15. log10 prior probability of mosaic genotype
# 16. log10 likelihood of major-homozygous genotype
# 17. log10 likelihood of heterozygous genotype
# 18. log10 likelihood of minor-homozygous genotype
# 19. log10 likelihood of mosaic genotype
# 20. log10 posterior probability of major-homozygous genotype
# 21. log10 posterior probability of heterozygous genotype
# 22. log10 posterior probability of minor-homozygous genotype
# 23. log10 posterior probability of mosaic genotype
# 24. Mosaic posterior probability
# You can get a high-confidence candidate list of mosaic sites by filtering the 24th column (mosaic posterior probability) or sorting this column from high to low.
# The 11+ columns are dependent on different modes of MosaicHunter's Bayesian genotypes, and you can find all of the details from the detailed version of the manual.

CMD ["/usr/bin/bash"]
