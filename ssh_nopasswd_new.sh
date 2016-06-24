#!/bin/bash
#newnode=$1
node[0]=$1  # hostname for each node
username=root            # username to be interconnected
homename=$username        # home dir
if [ "$username" = "root" ];
then
        homename=root
else
        homename=home/$username
fi

for((i=0; i<${#node[*]}; i++))
do
        ssh $username@${node[i]} 'ssh-keygen -t rsa; chmod 755 ~/.ssh'
done
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

echo "batch authorized_keys created..."
echo "start scp..."

#scp node003:/$homename/.ssh/authorized_keys /$homename/.ssh/node003.key
for((i=0; i<${#node[*]}; i++))
do
        scp ${node[i]}:/$homename/.ssh/id_rsa.pub /$homename/.ssh/${node[i]}.key
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
for((i=0; i<${#node[*]}; i++))
do
        scp /$homename/.ssh/authorized_keys ${node[i]}:/$homename/.ssh/authorized_keys
        echo "scp to ${node[i]} finished..."
done
echo "scp all nodes finished..."

# delete intermediate files
rm -rf /$homename/.ssh/*.key
echo "all configuration finished..."