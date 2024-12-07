#!/bin/dash

rm -rf repo

mkdir repo
cd repo

../pushy-init

# echo line 1 > a
# echo hello world >b

# ../pushy-add a b
# ../pushy-commit -m 'first commit'

# echo  line 2 >>a
# ../pushy-add a
# ../pushy-commit -m 'second commit'

# echo line 3 >>a
# ../pushy-add a

# echo line 4 >>a


# echo hello >a
# echo hello >b

# ../pushy-add a b

# ../pushy-commit -m 'first commit'

# echo 1 >a
# echo 2 >b
# ../pushy-add a b
# ../pushy-commit -m "first commit"
# echo 3 >c
# echo 4 >d
# ../pushy-add c d
# ../pushy-rm --cached  a c
# ../pushy-commit -m "second commit"
# ../pushy-show 0:a
# ../pushy-show 1:a
# ../pushy-show :a


# touch a b
# ../pushy-add a b
# ../pushy-commit -m "first commit"
# rm a
# ../pushy-commit -m "second commit"
# ../pushy-add a

# echo hello >a
# ../pushy-add a
# ../pushy-commit -m commit-A
# ../pushy-branch branchA
# echo world >b
# ../pushy-add b
# ../pushy-commit -m commit-B
# ../pushy-checkout branchA
# echo new contents >b
# ../pushy-checkout master
# pushy-checkout: error: Your changes to the following files would be overwritten by checkout:
# b
# pushy-add b
# pushy-commit -m commit-C
# Committed as commit 2
# pushy-checkout master
# Switched to branch 'master'


seq -f "line %.0f" 1 7 >a
seq -f "line %.0f" 1 7 >b
seq -f "line %.0f" 1 7 >c
seq -f "line %.0f" 1 7 >d
../pushy-add a b c d
../pushy-commit -m commit-0
# Committed as commit 0
../pushy-branch b1
../pushy-checkout b1
# Switched to branch 'b1'
seq -f "line %.0f" 0 7 >a
seq -f "line %.0f" 1 8 >b
seq -f "line %.0f" 1 7 >e
../pushy-add e
../pushy-commit -a -m commit-1
# Committed as commit 1
../pushy-checkout master
# Switched to branch 'master'
sed -i 4d c
seq -f "line %.0f" 0 8 >d
seq -f "line %.0f" 1 7 >f
../pushy-add f
../pushy-commit -a -m commit-2
# Committed as commit 2
# ../pushy-merge b1 -m merge1
# Committed as commit 3
# ../pushy-log
# 3 merge1
# 2 commit-2
# 1 commit-1
# 0 commit-0
# ../pushy-status
# a - same as repo
# b - same as repo
# c - same as repo
# d - same as repo
# e - same as repo
# f - same as repo



# seq 1 7 >7.txt
# ../pushy-add 7.txt
# ../pushy-commit -m commit-0
# # Committed as commit 0
# ../pushy-branch b1
# ../pushy-checkout b1
# # Switched to branch 'b1'
# sed -Ei s/2/42/ 7.txt
# ../pushy-commit -a -m commit-1
# # Committed as commit 1
# ../pushy-checkout master
# # Switched to branch 'master'
# sed -Ei s/5/24/ 7.txt
# ../pushy-commit -a -m commit-2
# # Committed as commit 2
# # ../pushy-merge b1 -m merge-message
# # # ../pushy-merge: error: These files can not be merged:
# # # 7.txt
# # ../pushy-log
# # # 2 commit-2
# # # 0 commit-0
# # ../pushy-status
# # # 7.txt - same as repo