#!/bin/bash

describe() {
    cat << EOF
    Description:
        Use bash to write a text batch processing script, and perform batch 
        processing on the following attachments to complete the corresponding 
        data statistics tasks
    Usage:
        bash $0 [-a] [-p] [-n] [-m] [-h]
    Options:
        a   Count the number of players in different age ranges 
            (below 20 years old, [20-30], over 30 years old), percentage
        p   Count the number and percentage of players in different positions 
            on the field
        n   Find the player with the longest name and shortest name
        m   Find the youngest and oldest player
        h   Details of this shell script
EOF
}

CheckFile(){
    if [[ ! -f "worldcupplayerinfo.tsv" ]];then
        wget https://c4pr1c3.github.io/LinuxSysAdmin/exp/chap0x04/worldcupplayerinfo.tsv
    fi
}

CountAge(){
    awk -F '\t' 'BEGIN { small=0; middle=0; high=0 }
    NR>1 {
        if ($6<20) {small++;}
        else if ($6<=30) {middle++;}
        else {high++;}
    }
    END {
        total=small+middle+high;
        printf("------------------------------------------\n");
        printf("| 年龄范围\t | 人数\t | 所占比例\t | \n");
        printf("------------------------------------------\n");
        printf("| 小于20岁\t | %d\t | %.2f%\t | \n",small,small/total*100);
        printf("| 20~30之间\t | %d\t | %.2f%\t | \n",middle,middle/total*100);
        printf("| 大于30岁\t | %d\t | %.2f%\t | \n",high,high/total*100);
    }
    ' worldcupplayerinfo.tsv
    exit 0
}

CountPosition(){
    awk -F "\t" ' 
    BEGIN {sum=0} 
    $5!="Position" { 
        pos[$5]++; 
        sum++; 
    }#统计各个位置，球员总数量 
    END { 
        printf("------------------------------------------\n");
        printf("| 位置\t | 数量\t | 百分比 | \n ");
        printf("------------------------------------------\n");
        for(i in pos) { 
            printf("| %13s\t | %d\t | %f%% | \n",i,pos[i],pos[i]*100.0/sum); 
        } 
    }' worldcupplayerinfo.tsv 
 } 


FindName(){
    awk -F '\t' 'BEGIN{ max=0; min=100; }
    NR>1 { 
        let=length($9);
        names[$9]=let;
        max=let>max?let:max;
        min=let<min?let:min; 
    }        
    END{
        for(i in names){            
            if(names[i]==max){
                print " 拥有最长名字的运动员:\t "i
            }
            else if(names[i]==min){
                print " 拥有最短名字的运动员:\t "i 
            }
        }
    } ' worldcupplayerinfo.tsv
}


FindAge(){
    awk -F '\t' 'BEGIN{ max=0; min=100; }
    NR>1 {
        ages[$9]=$6;
        max=$6>max?$6:max;
        min=$6<min?$6:min;
    }
    END{
        for(i in ages){
            if(ages[i]==max){
                print "最年长的球员: "ages[i]"\t name: " i "\t";
            }
            else if(ages[i]==min){
                print "最年轻的球员: "ages[i]"\t name: " i "\t";
            }
        }
    }' worldcupplayerinfo.tsv
    exit 0
}

# 先检查文件有没有，没有就下载
CheckFile
# 什么都不输入的时候输出使用方法
[[ $# -eq 0 ]] && describe

while getopts 'apnmh' OPT; do
    case $OPT in
        a)  
            CountAge 
            ;;
        p)
            CountPosition
            ;;
        n)
            FindName
            ;;
        m)
            FindAge
            ;;
        h | *) 
            describe 
            ;;
    esac
done