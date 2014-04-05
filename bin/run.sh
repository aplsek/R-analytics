#! /bin/sh

USAGE="Usage: `basename $0` inputFile runID"

if [ $# -ne 2 ]; then
    echo $USAGE >&2
    exit 1
fi

INPUT=$1
ID=$2


CWD=`pwd`
R_SRC=$CWD/R
# TODO: change go Rmd dir
RMD_SRC=$CWD

LIB_DIR=$CWD/lib
GC_PARSER=$LIB_DIR/gc-parser-0.1.0-standalone.jar
REPORTS_DIR=reports  
REPDIR=$REPORTS_DIR/$ID
REPORT_TEMPLATE=$RMD_SRC/report.Rmd

REPORT_NAME=$REPDIR/report.html

WWW_DIR=/var/www/html/gcLogs

INPUT_FILE_NAME=`basename $INPUT`
PARSED_LOG=$REPDIR/$INPUT_FILE_NAME.parsed

mkdir -p $REPDIR
cp $INPUT $REPDIR


# PARSE:
java -jar $GC_PARSER $REPDIR/$INPUT_FILE_NAME $PARSED_LOG

#cd $REPDIR
Rscript  $R_SRC/knitr.R $REPORT_TEMPLATE $PARSED_LOG $ID $REPORT_NAME
mv figure $REPDIR

#cd $CWD


#PUBLISH
cp -r $REPDIR $WWW_DIR