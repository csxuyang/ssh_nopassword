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
passwd=111111
username=root            # username to be interconnected
homename=$username        # home dir

for((i=0; i<${#nodes[*]}; i++))
do
        scp /$homename/reset_ambari.sh ${nodes[i]}:/$homename/
        echo "scp from ${nodes[i]} finished..."
done
for((i=0; i<${#nodes[*]}; i++))
do
        ssh $username@${nodes[i]} \"/root/reset_ambari.sh\"
       
done
echo "all clean finished..."
