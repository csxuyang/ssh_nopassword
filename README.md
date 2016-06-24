### ssh_nopassword
自动配置ssh 无秘钥<br>
ssh_nopassword.sh 需配置node变量，如果(node1 node2 node3)，就是node2 node3 对于node1免秘钥登录 <br>

ssh_nopassword_new.sh 有时候需要增加新节点，使用这个脚本，node4 node5 增加对当前节点的免秘钥登录 <br>
```
ssh_nopassword_new.sh node4 node5 
```