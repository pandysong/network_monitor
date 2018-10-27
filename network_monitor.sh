ping -c 1 www.google.com.au >/dev/null 2>&1
pingvalue=$?
echo -n `date '+%Y-%m-%d %H:%M:%S'`
if [ $pingvalue = 0 ]; then
    echo " start: it is online now"
else
    echo " start: it is offline now"
fi

START=$(date +%s)
while true; do 
    ping -c 1 www.google.com.au >/dev/null 2>&1
    pingvaluenew=$?
    if [ $pingvaluenew = 0 ];  then
        if [ $pingvalue != 0 ]; then
            pingvalue=$pingvaluenew
            END=$(date +%s)
            current_date_time=`date '+%Y-%m-%d %H:%M:%S'`
            echo -n $current_date_time;
            echo -n $((END-START)) | awk '{print " after down time: "int($1/60)":"int($1%60)" go online"}'
            START=$END
        fi
    else
        if [ $pingvalue = 0 ]; then
            pingvalue=$pingvaluenew
            current_date_time=`date '+%Y-%m-%d %H:%M:%S'`
            END=$(date +%s)
            echo -n $current_date_time;
            echo -n $((END-START)) | awk '{print " after up time: "int($0/60)":"int($1%60)" go offline"}'
            START=$END
        fi
    fi
    sleep 1; 
done
