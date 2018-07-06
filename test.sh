#! /bin/bash
# (#!) 这里是用 /bin/sh 做解释器

echo "Hello World !" 


echo ----------------------------------变量
# 变量的使用
a=1
echo ${a}00  $a

echo "$a"      # 输出 1
echo '$a'      # 输出 $a

set | grep 'a=' 
env | grep 'a='

echo $PWD   

echo ----------------------------------if判断
# if判断
abc="1"
[[ $abc = 1 ]] && echo "yes" || echo "not"
[[ $abc == 1 ]] && echo "yes" || echo "not"
# 或者 
[[ $abc -eq 1 ]] && echo "yes" || echo "not"
# 输出结果都是 yes

echo ----------------------------------循环1
for f in `ls`; do
	echo $f
done
echo ----------------------------------循环2
resource_dir=$PWD #当前路径
filelist=`ls $resource_dir`
for file in $filelist
do
    echo $file
done

# linux 三剑客命令(grep,sed ,awk)
# -记住三个命令的运用形式
#      grep    '字符'       文件
#      sed     '命令'       文件
#      awk    '条件{命令}'   文件
# -死记一点，单引号内就是正则表达式的用法
echo ----------------------------------grep强大的文本检索

# 在package.json文件中找到匹配条件的。
# -n 为显示行号。
# -E 满足多个条件： grep -E 'word1|word2'
# -v 显示不包含匹配文本的所有行
echo ----所有的min
grep -n 'min' package.json  # 
echo "asdminsadasdasds" | grep 'min'

echo ---- 包含 gulp galp
grep 'g[ua]lp'   package.json  #

echo ---- 非gulp的 g.lp
grep  'g[^u]lp'  package.json    # 

echo ---- 必须^hol开头, 前面有空格也不行
grep  '^hol'    package.json     # 

echo ---- 必须^gram\",\$结尾
grep  'gram",$'    package.json  # 

echo ---- 四个字符 g..p
grep    'g..p'   package.json    #

echo ---- 任意多个字符cl cll clll
grep    'cl*l'    package.json   # 

echo ---- 找到gpp,gppp,注意{}在 shell中有特殊含义，故需要转义.
grep   'gp\{2,3\}'    package.json 

echo ----------------------------------sed ⚠️ 不知道这里进行操作后为什么,没有换行
# Mac 自带的时 BSD 版本的 sed，因为功能较弱，我不推荐使用，建议使用 gsed，如无特殊说明，下文的介绍都是针对 gsed的。
# brew install coreutils
# which gsed
# /usr/local/bin/gsed
# https://bestswifter.gitbook.io/effectivemac/zhong-ji-wu-qi-zsh/bi-hui-xi-tong-ming-ling

# -n或--quiet或--silent 仅显示script处理后的结果。
# -i  直接编辑文件而不是显示在屏幕上

echo ---- 删除7行的 数据
sed  '7d'        sed.txt

echo ---- 在第4行增加
sed  '4a\
newLine' sed.txt

echo ---- 2-4行 替换
sed  '2,4c\
holle word !'     sed.txt 

echo ---- 2-5行 打印
sed  -n '2,5p'  sed.txt 

echo ---- 第3行前插入：
sed  '3i\ 
 newline' sed.txt 

echo ---- 将1-10行里面的 pcprogram替换为temp-\>,可在文件中查看效果, 源文件备份到sed.txt_original
sed  -i '_original' '1,10s/pcprogram/temp->/g'  sed.txt  

echo ----------------------------------awk 以字段为单位进行处理\(其实就是把一行的数据分割，然后进行处理\)
#  1.$0   代表一整行的数据
#  2.$1   代表第一个字段，用人的话来说就是第一列的数据
#  3.$2   以此类推
#  4.NF   每一行拥有的字段总数
#  5.NR   目前处理的是第几行的数据
#  6.FS   目前的分隔字符

CP_sourceDIR='/Users/admin/Desktop/web项目/1-NPM/sh' 
awk  '{print   $1  "\t"  $2 "\t" $3 "\t" $4 "\t" $5 }'   /Users/admin/Desktop/web项目/1-NPM/sh 

echo ----  前五行的 第一行，第二行，第三行
awk  'NR<6{print   $1  "\t"  $2 "\t" $3 "\t" $4 "\t" $5 }'     sed.txt  

awk '{print "该行数据为" $0 "\t" "该行的字段总数为"  NF   "\t"  "目前这是第几行"  NR}'   sed.txt 

echo ---- 把passwd文件中的第一列，第三列打印出来（条件：第三列数字 \< 10）
awk  'BEGIN{FS=":"}  $3<10{print $1 "\t" $3}'    /etc/passwd 


bsfilename