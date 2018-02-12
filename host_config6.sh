#!/bin/bash

node=(p1 p_2_10)  # hostname for each node
nodes=()
substr="_"
for((i=0; i<${#node[*]}; i++));do
  echo ${node[i]}
  if [[ ${node[i]} == *$substr* ]];then
    str_head=`echo ${node[i]} | cut -d $substr -f 1`
    str_start=`echo ${node[i]} | cut -d $substr -f 2`
    str_end=`echo ${node[i]} | cut -d $substr -f 3`
    let start=$str_start
    let end=$str_end
    for((i=$start; i<=$end; i++));do
       hostname="$str_head""$i"
       nodes+=($hostname)
    done
  else
    nodes+=(${node[i]})
  fi
done

echo ${nodes[@]}
passwd=cnic.cn
username=root            # username to be interconnected
homename=$username        # home dir
if [ "$username" = "root" ];
then
        homename=root
else
        homename=home/$username
fi
dist=$(tr -s ' \011' '\012' < /etc/issue | head -n 1)
if [ "$dist" = "Ubuntu" ]
then
    #make login self enable
	yes | ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys  
	
	echo "set hostname"
	hostname_prefix="packone"
	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn ssh $username@${nodes[i]} \"hostnamectl --static set-hostname ${nodes[i]};ufw disable;ulimit -n 10000;\"
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done

	echo "scp /etc/hosts"

	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn scp /etc/hosts $username@${nodes[i]}:/etc/
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done

	echo "ntpd sync"
	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn ssh $username@${nodes[i]} \"cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;ntpdate us.pool.ntp.org;\"
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done

	echo "ssh nopasswd"
	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn ssh $username@${nodes[i]} \"yes | ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ''; chmod 755 ~/.ssh\"
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done
	echo "batch authorized_keys created..."
	echo "start scp..."

	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn scp ${nodes[i]}:/$homename/.ssh/id_rsa.pub /$homename/.ssh/${nodes[i]}.key
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	   echo "scp from ${nodes[i]} finished..."
	done

	echo "append key to authorized_keys..."
	for((i=0; i<${#nodes[*]}; i++))
	do
	   cat /$homename/.ssh/${nodes[i]}.key >> /$homename/.ssh/authorized_keys
	   echo "append ${nodes[i]}.key finished..."
	done

	echo "append all key finished..."
	loop=${#nodes[*]}
	let subloop=loop-1
	echo "starting scp complete authorized_keys to ${nodes[1]}~${nodes[subloop]}"
	for((i=1; i<${#nodes[*]}; i++))
	do
	 expect -c "
	   spawn scp /$homename/.ssh/authorized_keys ${nodes[i]}:/$homename/.ssh/authorized_keys 
	   expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
			
		echo "scp to ${nodes[i]} finished..."
	done
	echo "scp all nodess finished..."

	# delete intermediate files
	rm -rf /$homename/.ssh/*.key
	echo "all configuration finished..."
else
	echo "set hostname"
	hostname_prefix="packone"
	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn ssh $username@${nodes[i]} \"sed -i 's/localhost.localdomain/${nodes[i]}/g' /etc/sysconfig/network;hostname ${nodes[i]};ufw disable;ulimit -n 10000;\"
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done

	echo "scp /etc/hosts"

	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn scp /etc/hosts $username@${nodes[i]}:/etc/
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done

	echo "ntpd sync"
	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn ssh $username@${nodes[i]} \"yum install -y ntp;chkconfig --level 5 ntpd on;service ntpd start;cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;ntpdate us.pool.ntp.org;\"
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done

	echo "ssh nopasswd"
	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn ssh $username@${nodes[i]} \"yes | ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ''; chmod 755 ~/.ssh\"
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	done
	echo "batch authorized_keys created..."
	echo "start scp..."

	for((i=0; i<${#nodes[*]}; i++))
	do
	   expect -c "
		spawn scp ${nodes[i]}:/$homename/.ssh/id_rsa.pub /$homename/.ssh/${nodes[i]}.key
		expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
	   echo "scp from ${nodes[i]} finished..."
	done

	echo "append key to authorized_keys..."
	for((i=0; i<${#nodes[*]}; i++))
	do
	   cat /$homename/.ssh/${nodes[i]}.key >> /$homename/.ssh/authorized_keys
	   echo "append ${nodes[i]}.key finished..."
	done

	echo "append all key finished..."
	loop=${#nodes[*]}
	let subloop=loop-1
	echo "starting scp complete authorized_keys to ${nodes[1]}~${nodes[subloop]}"
	for((i=1; i<${#nodes[*]}; i++))
	do
	 expect -c "
	   spawn scp /$homename/.ssh/authorized_keys ${nodes[i]}:/$homename/.ssh/authorized_keys 
	   expect {
		   \"*assword\" {set timeout 300; send \"$passwd\r\";}
		   \"yes/no\" {send \"yes\r\"; exp_continue;}
		  }
	   expect eof"
			
		echo "scp to ${nodes[i]} finished..."
	done
	echo "scp all nodess finished..."

	# delete intermediate files
	rm -rf /$homename/.ssh/*.key
	echo "all configuration finished..."
fi
