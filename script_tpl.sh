#!/usr/bin/env bash

# =========================================== COPYRIGHT ===========================================
readonly SCRIPT_NAME="script_tpl.sh" # 脚本名称
readonly SCRIPT_DESC="Shell 脚本模板，已预制常用常量、变量、方法定义，及复杂参数解析，以便快速开始核心编程。" # 脚本名称
readonly SCRIPT_VERSION="1.2.0" # 脚本版本
readonly SCRIPT_UPDATETIME="2021/04/01" # 最近的更新时间
readonly AUTHER_NAME="MengXinxin" # 作者
readonly AUTHER_EMAIL="andy_m129@163.com" # 作者邮箱
readonly REAMDME_URL="https://github.com/AndyM129/ShellScriptTpl" # 说明文档
readonly SCRIPT_UPDATE_LOG='''
### 2022/03/14: v1.2.0

* 清除所有警告

### 2021/04/01: v1.1.0

* 参考 `pod` 命令，扩展实现 支持命令、选项、参数，或同时输入的参数处理，如：

  ```shell
  sh template_2.sh -d command p1 p2 p3 p4,p5,p6 "p7 p8 p9" --option1 -subOption1 -subOption2 --option2 aaa -subOption1 bbb --option3 "ccc" -subOption1 "ddd" -subOption2 eee "fff ggg"
  ```

### 2021/03/31: v1.0.0

* 立项，参考 `xcodebuild` 命令，实现基于参数键值对方式的参数处理，如：

  ```shell
  sh template.sh --command1 -option11 aaa -option12 bbb --command2 -option21 ccc -option22 ddd eee fff ggg
  ```
'''

# =========================================== GLOBAL CONST ===========================================
readonly MACOS_VER="$(/usr/bin/sw_vers -productVersion)" # 当前 MacOS 版本，eg. 11.0.1
readonly TIMESTAMP=$(date +%s) # 当前时间戳，eg. 1617351251
readonly DATE=$(date -r "$TIMESTAMP" "+%Y-%m-%d %H:%M:%S") # 当前时间，eg. 2021-04-02 16:14:11
readonly DATE_STAMP=$(date -r "$TIMESTAMP" "+%Y%m%d%H%M%S") # 当前时间戳，eg. 20210402161411
readonly CURRENT_PATH=$(pwd); # 当前所在路径
readonly SCRIPT_DIRPATH=$(dirname "$0"); # 当前脚本的文件路径
readonly SCRIPT_BASENAME=$(basename "$0"); # 当前脚本的文件名
readonly SCRIPT_BASENAME_WITHOUT_SUFFIX=${SCRIPT_BASENAME%.*} # 文件名（不含后缀）
readonly SCRIPT_BASENAME_SUFFIX=${SCRIPT_BASENAME##*.} # 文件后缀

# =========================================== GLOBAL VARIABLES ===========================================
verbose="0"
debug="0"

# =========================================== GLOBAL FUNCTIONS ===========================================
echoDebug() { if [[ $verbose == "1" || $debug == "1" ]]; then echo "\033[1;2m$@\033[0m"; fi;}      # debug 级别最低，可以随意的使用于任何觉得有利于在调试时更详细的了解系统运行状态的东东；
echoInfo() { echo "\033[1;36m$@\033[0m"; }      # info  重要，输出信息：用来反馈系统的当前状态给最终用户的；
echoSuccess() { echo "\033[1;32m$@\033[0m"; }   # success 成功，输出信息：用来反馈系统的当前状态给最终用户的；
echoWarn() { echo "\033[1;33m$@\033[0m"; }      # warn, 可修复，系统可继续运行下去；
echoError() { echo "\033[1;31m$@\033[0m"; }     # error, 可修复性，但无法确定系统会正常的工作下去;
echoFatal() { echo "\033[5;31m$@\033[0m"; }     # fatal, 相当严重，可以肯定这种错误已经无法修复，并且如果系统继续运行下去的话后果严重。

# =========================================== HELP ===========================================
help() {
    echoInfo "脚本名称: $SCRIPT_NAME"
    echoInfo "功能简介: $SCRIPT_DESC"
    echoInfo "当前版本: $SCRIPT_VERSION"
    echoInfo "最近更新: $SCRIPT_UPDATETIME"
    echoInfo "作    者: $AUTHER_NAME <$AUTHER_EMAIL>"
    echoInfo "说明文档: $REAMDME_URL"
    echoInfo
    echoInfo "============================================================="
    echoInfo
    echoInfo "Usage:"
    echoInfo
    echoInfo "\t\$ sh $SCRIPT_NAME [-dvh] [command] [params...] [--Option [value] [-sub_option [value]]...]..."
    echoInfo
    echoInfo "Commands:"
    echoInfo "\tcommand1:\t命令1"
    echoInfo "\tcommand2:\t命令2"
    echoInfo
    echoInfo "Options:"
    echoInfo "\t--opt1:\t\t选项1"
    echoInfo "\t--opt2:\t\t选项2"
    echoInfo "\t--updatelog:\t脚本的更新日志"
    echoInfo "\t--version:\t当前脚本版本"
    echoInfo "\t--help:\t\t查看使用说明"
    echoInfo
    echoInfo "SubOptions:"
    echoInfo "\t-sub_opt1:\t子选项1"
    echoInfo "\t-sub_opt2:\t子选项2"
}

# =========================================== PROCESS ===========================================

process() {
    echoSuccess "process() 收到参数 $#个：$@"
    echoSuccess
    echoSuccess "Done !"
    exit 0;
}

# =========================================== MAIN ===========================================

main() {
    if [[ $1 && ${1:0:2} != "--" ]]; then
        while getopts "dvh" OPT; do
            case $OPT in
                d) debug="1" ;;
                v) verbose="1" ;;
                h) help="1" ;;
                ?) help; exit 1 ;;
            esac
        done
        shift $((OPTIND-1))
    fi

    echoDebug; 
    echoDebug "======================== DATE ======================"
    echoDebug "$DATE"
    echoDebug; 
    echoDebug "======================== GLOBAL CONST ======================"
    echoDebug "\$MACOS_VER=$MACOS_VER"
    echoDebug "\$TIMESTAMP=$TIMESTAMP"
    echoDebug "\$DATE=$DATE"
    echoDebug "\$DATE_STAMP=$DATE_STAMP"
    echoDebug "\$CURRENT_PATH=$CURRENT_PATH"
    echoDebug "\$SCRIPT_DIRPATH=$SCRIPT_DIRPATH"
    echoDebug "\$SCRIPT_BASENAME=$SCRIPT_BASENAME"
    echoDebug "\$SCRIPT_BASENAME_WITHOUT_SUFFIX=$SCRIPT_BASENAME_WITHOUT_SUFFIX"
    echoDebug "\$SCRIPT_BASENAME_SUFFIX=$SCRIPT_BASENAME_SUFFIX"
    echoDebug; 
    echoDebug "======================== Command ======================"
    echoDebug "sh $0 $*"
    echoDebug; 
    echoDebug "======================== Parsing options ======================"
    commandParams=();
    currentOptionKey=""
    currentSubOptionKey=""
    currentCommandParamIndex=-1

    while [ -n "$1" ]; do
        case "$1" in     
            --*)
                currentSubOptionKey="";
                currentOptionKey="${1:2}"
                currentOptionValue="$([[ -z $2 || ${2:0:1} == "-" ]] && echo '1' || echo $2)";
                eval ${currentOptionKey}='$currentOptionValue'
                echoDebug "\$$currentOptionKey=$currentOptionValue"
                shift $([[ -z $2 || ${2:0:1} == "-" ]] && echo 0 || echo 1);;
            -*) 
                currentOptionKeyPrefix=$([ $currentOptionKey ] && echo "${currentOptionKey}_" || echo "")
                currentSubOptionKey="${currentOptionKeyPrefix}${1:1}"
                currentSubOptionValue=""
                while [[ -n "$2" && ${2:0:1} != "-" ]]; do
                    shift
                    currentSubOptionValue=$([[ -z $currentSubOptionValue  ]] && echo "$1" || echo "$currentSubOptionValue $1")
                done
                if [[ -z $currentSubOptionValue ]]; then currentSubOptionValue="1"; fi
                echoDebug "\$$currentSubOptionKey=$currentSubOptionValue"
                eval ${currentSubOptionKey}='$currentSubOptionValue'
                shift $([[ -z $2 || ${2:0:1} == "-" ]] && echo 0 || echo 1);;
            *)
                let currentCommandParamIndex=$currentCommandParamIndex+1
                commandParams[$currentCommandParamIndex]=$1
                echoDebug "\$$currentCommandParamIndex=$1" 
                # if $debug; then echoDebug "\$$currentCommandParamIndex=$1"; fi
                # echoSuccess "commandParams count=${#commandParams[@]}，items=${commandParams[@]}"
        esac
        shift
    done
    unset -v currentOptionKey; unset -v currentSubOptionKey; unset -v currentCommandParamIndex; 

    echoDebug; echoDebug "======================== Params ======================"
    currentParamIndex=1
    echoDebug "\$0=$0"
    for param in ${commandParams[@]}; do
        echoDebug "\$$currentParamIndex=$param"
        currentParamIndex=$[ $currentParamIndex + 1 ]
    done
    unset -v currentParamIndex

    echoDebug "======================== GLOBAL VARIABLES ======================"
    echoDebug "debug=$debug"
    echoDebug "verbose=$verbose"
    echoDebug; 
    echoDebug "=============================================="; echoDebug

    # 预制处理
    if [ $help ]; then help; exit 0; fi;
    if [ $version ]; then echoInfo "$SCRIPT_VERSION"; exit 0; fi;
    if [ $updatelog ]; then echoInfo "$SCRIPT_UPDATE_LOG"; exit 0; fi;

    # 开始处理
    process ${commandParams[@]}
}

main $@