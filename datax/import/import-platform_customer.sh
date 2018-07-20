# sh run-platform_customer.sh 20180424

if [ $# -eq 0 ]
then
    echo "absent parameter yyyymmdd"
    exit
fi

rdate=$1

echo $rdate

echo ==== create datax.json

# 全量
python3 createjson-pt.py dbo_platform_customer $rdate

# 增量
# python3 createjson-pt.py dbo_platform_customer_dadd $rdate

echo ==== datax
# 全量
python /var/www/datax/bin/datax.py day/odps2postgresql-dbo_platform_customer-$rdate.json

# 增量
# python /var/www/datax/bin/datax.py day/odps2postgresql-dbo_platform_customer_dadd-$rdate.json


echo ==== psql
psql  -v pt="'$rdate'" -f import/import-platform_customer-after.sql "dbname=xueshandai user=xueshandai password=Xueshandai123$"