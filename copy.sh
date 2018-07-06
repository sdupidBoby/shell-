#! /bin/sh 


CP_destDIR='/Users/admin/Desktop/copyFloder' 
CP_sourceDIR='/Users/admin/Desktop/web项目/1-NPM/sh/' 
CP_sourceDIR1='/Users/admin/Desktop/web项目' 

for f in `ls $CP_sourceDI`; do
	echo $f
    # grep -vE 'node_modules|.git' $f

    if [[ $f != 文件夹2 ]]; then
        cp -a $f /Users/admin/Desktop/copyFloder
    fi
done


# 列出当前目录下的所有级文件夹，除了“文件夹2|.git” 
find $CP_sourceDIR -type d | grep -vE '文件夹2|.git' 

# 列出当前目录下的所有一级文件(/夹)，除了“文件夹2” 
ls | grep -v 文件夹2 | xargs echo

