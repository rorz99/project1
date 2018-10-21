#!/bin/bash
if (( $# < 2 )); then
echo sample：$0 server aaaaaaaaaaaaa@bbc.com desc
   exit -1
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
export SSH_AGENT_PID=`ps -fe |awk '!/awk/&&/ssh-agent/&&/'$USER'/ {print $2}'`
Server=$1
Mail=$2
LOG=~/ping.log
b=0    #初始赋值为0，刚启动脚本时测试到网络正常则不提示，解决每次启动脚本时都提示网络正常的问题(设置为其他值则每次启动脚本时都提示)。
while [ true ]
        do 
	  P=`ping -w 3 $Server`
          [ `echo "$P"| grep 'time=' | wc -l` -gt 0 ] > /dev/null    #允许ping超时2次。
	#	ping -q -c 3 $Server >/dev/null
                a=$?
                if [ $a -ne 0 ]    #判断执行上面ping命令是否正常，为0则网络正常，否则提示网络中断。
                        then
                        if [ $a -ne $b ]    #解决网络中断时一直提示的问题。
                                then
                                b=$a    #给予下次判断网络是否正常。
				aa="-------------`date +%Z_%Y/%m/%d_%H:%M:%S`---------------------------"
				bb="$Server 当前状态："
				cc=$P
				sleep 20 && ssh cn@c000 "sudo -u wprod /usr/local/bin/su_web xautolog $Server" 
				#/home/cn052942/checkagent.sh p
				dd="/home/db2inst1/checksession.db2 ismcache xxdba xxxxxxxxxx"
				ee="-------------`date +%Z_%Y/%m/%d_%H:%M:%S`---------------------------"
				echo -e "$aa" "\n" "$bb" "\n" "$cc" "\n" "$dd" "\n" "$ee" |mail -s "$3 $Server : Network interrupt!!" $Mail
                                #sed -n "/${Datetime1}/,/^中断/p" $LOG |mail -s "警报警报：网络中断！！" $Mail    
                        fi
                else
                        if [ $a -ne $b ]    #解决网络正常时一直提示的问题。
                                then
                                b=$a    #给予下次判断网络是否正常。
				aa="-------------`date +%Z_%Y/%m/%d_%H:%M:%S`---------------------------"
				bb="$Server 当前状态："
				cc=$P
				dd=`traceroute -n -m 20 $Server`
				ee="-------------`date +%Z_%Y/%m/%d_%H:%M:%S`---------------------------"
				echo -e "$aa" "\n" "$bb" "\n" "$cc" "\n" "$dd" "\n" "$ee" |mail -s "$3 $Server : Network recover!!" $Mail
				#sed -n "/$Datetime2/,/^恢复/p" $LOG | mail -s "$3 $server 通知：网络恢复正常" $Mail 
                                #echo '通知：网络恢复正常！！' | mail -s '$Server 网络恢复正常' $Mail <  `sed -n "/${Datetime2}/,/^恢复/p" $LOG`                
                         fi
               fi
#sleep 180
done
