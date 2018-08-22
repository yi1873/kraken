# kraken alignment

docker run --rm -v /path:/path lxz/kraken:1.0 \
    /kraken/krakenhll --db /path/kraken.db \
    --report-file /path/test.kraken_result.txt \
    --threads 7 --fastq \
    /path/test_1.fq.gz \
    /path/test_2.fq.gz \
    --gzip-compressed --paired \
    --output /path/test.kraken

docker run --rm -v /path:/path lxz/kraken:1.0 \
    /kraken/kraken-filter --db /path/kraken.db \
    --threshold 0.2 /path/test.kraken > /path/test.filter0.2.kraken
    
docker run --rm -v /path:/path lxz/kraken:1.0 \
    /kraken/kraken-mpa-report --db /path/kraken.db \
    /path/test.filter0.2.kraken > /path/test.kraken.map.txt

# convert kraken report to krona format

docker run --rm -v /path:/path lxz/kraken:1.0 \
    /metaphlan2/utils/metaphlan2krona.py \
    -p /path/test.kraken.mpa.txt -k /path/test.krona.out

# krona html display
docker run --rm -v /path:/path lxz/kraken:1.0 \
       /kraken/Krona/KronaTools/scripts/ImportText.pl -o /path/test/test.kraken.krona.html \
       /path/test/test.krona.out
