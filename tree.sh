# !/bin/bash
 
# 转译符号:  \

# ⚠️⚠️⚠️⚠ 这是自己实现的一个tree显示文件目录结构的shell ⚠️⚠️⚠️
# 使用方式：sh /Users/admin/Desktop/web项目/1-NPM/sh/tree.sh /Users/admin/Desktop/web项目/1-NPM/sh

file=/dir1/dir2/dir3/my.file.txt
# #是去掉左边（键盘上#在 $ 的左边）(从最左边开始)
# %是去掉右边（键盘上% 在$ 的右边）(从最右边开始)
# 单一符号是最小匹配；两个符号是最大匹配；
# ${file:0:5}：提取最左边的5 个字节：/dir1
# ${file:5:5}：提取第5 个字节右边的连续5个字节：/dir2

echo "去掉最左边/前面,输出："${file##*/} #get the dir name, remove the path    输出：sh
echo "shell\($0)目录结构:"

current_path=$1  # 在这里修改 路径

output_dir()
{
    dir=$1    #dir is a globle varible
    elements=`ls $dir`

    if [ $current_path == $dir ]; then
        echo "."  
    fi
    
    for each in $elements
    do
        echo "$2"$each
        if [ -d $1"/"$each ] # 是否还有下一级目录
        then
            output_dir $1"/"$each "| $2"    #here, dir will be changed, and be used in the outloop  
        fi
    done
}
output_dir $current_path "|____"  # first para is directory, second para is space

exit 1 #推出
.
|____ABuild.sh
|____Automator
| |____archive_demo.workflow
| | |____Contents
| | | |____Info.plist
| | | |____QuickLook
| | | | |____Preview.png
| | | |____document.wflow
|____copy.sh
|____iOSArchivefile
| |____ExportOptions.plist
|____package.json
|____sed.txt
|____sed.txt_original
|____test.sh
|____tree.sh
|____文件夹1
| |____floder1
| | |____hahah
|____文件夹2
| |____floder
| | |____new