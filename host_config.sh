#!/bin/bash
node=(packone52 packone55 packone56)  # hostname for each node
passwd=cnic.cn
username=root            # username to be interconnected
homename=$username        # home dir
if [ "$username" = "root" ];
then
        homename=root
else
        homename=home/$username
fi

echo "set hostname"
hostname_prefix = "packone"
for((i=0; i<${#node[*]}; i++))
do
   expect -c "
    spawn ssh $username@${node[i]} \"rm /etc/hostname;echo ${node[i]} >> /etc/hostname;service firewalld stop;ulimit -n 10000;\"
    expect {
       \"*assword\" {set timeout 300; send \"$passwd\r\";}
       \"yes/no\" {send \"yes\r\"; exp_continue;}
      }
   expect eof"
done

echo "scp /etc/hosts"

for((i=0; i<${#node[*]}; i++))
do
   expect -c "
    spawn scp /etc/hosts $username@${node[i]}:/etc/
    expect {
       \"*assword\" {set timeout 300; send \"$passwd\r\";}
       \"yes/no\" {send \"yes\r\"; exp_continue;}
      }
   expect eof"
done

echo "ntpd sync"
for((i=0; i<${#node[*]}; i++))
do
   expect -c "
    spawn ssh $username@${node[i]} \"chkconfig --level 5 ntpd on;service ntpd start;cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;ntpdate us.pool.ntp.org;\"
    expect {
       \"*assword\" {set timeout 300; send \"$passwd\r\";}
       \"yes/no\" {send \"yes\r\"; exp_continue;}
      }
   expect eof"
done

echo "ssh nopasswd"
for((i=0; i<${#node[*]}; i++))
do
   expect -c "
    spawn ssh $username@${node[i]} \"yes | ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ''; chmod 755 ~/.ssh\"
    expect {
       \"*assword\" {set timeout 300; send \"$passwd\r\";}
       \"yes/no\" {send \"yes\r\"; exp_continue;}
      }
   expect eof"
done
echo "batch authorized_keys created..."
echo "start scp..."

for((i=0; i<${#node[*]}; i++))
do
   expect -c "
    spawn scp ${node[i]}:/$homename/.ssh/id_rsa.pub /$homename/.ssh/${node[i]}.key
    expect {
       \"*assword\" {set timeout 300; send \"$passwd\r\";}
       \"yes/no\" {send \"yes\r\"; exp_continue;}
      }
   expect eof"
   echo "scp from ${node[i]} finished..."
done

echo "append key to authorized_keys..."
for((i=0; i<${#node[*]}; i++))
do
   cat /$homename/.ssh/${node[i]}.key >> /$homename/.ssh/authorized_keys
   echo "append ${node[i]}.key finished..."
done

echo "append all key finished..."
loop=${#node[*]}
let subloop=loop-1
echo "starting scp complete authorized_keys to ${node[1]}~${node[subloop]}"
for((i=1; i<${#node[*]}; i++))
do
 expect -c "
   spawn scp /$homename/.ssh/authorized_keys ${node[i]}:/$homename/.ssh/authorized_keys 
   expect {
       \"*assword\" {set timeout 300; send \"$passwd\r\";}
       \"yes/no\" {send \"yes\r\"; exp_continue;}
      }
   expect eof"
        
    echo "scp to ${node[i]} finished..."
done
echo "scp all nodes finished..."

# delete intermediate files
rm -rf /$homename/.ssh/*.key
echo "all configuration finished..."
