 #!/usr/bin/env bash

# =========================================== COPYRIGHT ===========================================
readonly SCRIPT_NAME="script_tpl.sh" # 脚本名称
readonly SCRIPT_DESC="Shell 脚本模板" # 脚本名称
readonly CURRENT_VERSION="1.0.0" # 脚本版本
readonly LAST_UPDATETIME="2021/03/31" # 最近的更新时间
readonly AUTHER_NAME="MengXinxin" # 作者
readonly AUTHER_EMAIL="andy_m129@163.com" # 作者邮箱
readonly REAMDME_URL="https://github.com/AndyM129/ShellScriptTpl" # 说明文档

# =========================================== GLOBAL CONST ===========================================
readonly MACOS_VER="$(/usr/bin/sw_vers -productVersion)" # 当前 MacOS 版本
readonly DATE=$(date "+%Y-%m-%d %H:%M:%S") # 当前时间
readonly DATE_STAMP=${DATE//-: /} # 当前时间戳
readonly DIRPATH=$(dirname $0); # 文件路径
readonly BASENAME=$(basename $0); # 文件名
readonly BASENAME_WITHOUT_SUFFIX=${BASENAME%.*} # 文件名（不含后缀）
readonly BASENAME_SUFFIX=${BASENAME##*.} # 文件后缀

# =========================================== GLOBAL VARIABLES ===========================================
verbose="1"
debug="0"

# =========================================== GLOBAL FUNCTIONS ===========================================
echo_debug() { if [[ $verbose == "1" || $debug == "1" ]]; then echo "\033[1;2m$@\033[0m"; fi;}      # debug 级别最低，可以随意的使用于任何觉得有利于在调试时更详细的了解系统运行状态的东东；
echo_info() { echo "\033[1;36m$@\033[0m"; }      # info  重要，输出信息：用来反馈系统的当前状态给最终用户的；
echo_success() { echo "\033[1;32m$@\033[0m"; }   # success 成功，输出信息：用来反馈系统的当前状态给最终用户的；
echo_warn() { echo "\033[1;33m$@\033[0m"; }      # warn, 可修复，系统可继续运行下去；
echo_error() { echo "\033[1;31m$@\033[0m"; }     # error, 可修复性，但无法确定系统会正常的工作下去;
echo_fatal() { echo "\033[5;31m$@\033[0m"; }     # fatal, 相当严重，可以肯定这种错误已经无法修复，并且如果系统继续运行下去的话后果严重。
git_branch_name() { git symbolic-ref --short HEAD; }

# =========================================== HELP ===========================================
help() {
    echo_info "脚本名称: $SCRIPT_NAME"
    echo_info "功能简介: $SCRIPT_DESC"
    echo_info "当前版本: $CURRENT_VERSION"
    echo_info "最近更新: $LAST_UPDATETIME"
    echo_info "作    者: $AUTHER_NAME <$AUTHER_EMAIL>"
    echo_info "说明文档: $REAMDME_URL"
    echo_info
    echo_info "============================================================="
    echo_info
    echo_info "Usage:"
    echo_info
    echo_info "\t\$ sh $SCRIPT_NAME [--Command] [-Option [value]] [--] [params...]"
    echo_info
    echo_info "Commands:"
    echo_info "\tcommand1:\t\t命令1"
    echo_info "\tcommand2:\t\t命令2"
    echo_info
    echo_info "Options:"
    echo_info "\t--debug:\t打开调试模式."
    echo_info "\t--verbose:\t显示更多的调试信息."
    echo_info "\t--help:\t显示使用说明."
    echo_info
    echo_info "Params:"
    echo_info "\tparam1:\t参数1"
    echo_info "\tparam2:\t参数2"
}

# =========================================== PROCESS ===========================================

process() {
    echo_success "Done !"
    exit 0;
}

# =========================================== MAIN ===========================================

main() {
    echo_debug; echo_debug "======================== Date ======================"
    echo_debug "$DATE"
    echo_debug; echo_debug "======================== Command ======================"
    args=("$@")
    echo_debug "sh $0 $*"

    if [[ -n $1 && ${1:0:1} == "-" ]]; then
        echo_debug; echo_debug "======================== Parsing options ======================"
        current_command_key=""
        current_option_key=""
        current_param_index=0
        while [ -n "$1" ]; do
            case "$1" in    
                --) 
                    current_command_key=""; current_option_key=""; current_param_index=0;
                    shift
                    break ;;    
                --*)
                    current_option_key=""; current_param_index=0;
                    current_command_key="${1:2}"
                    current_command_value="$([[ -z $2 || ${2:0:1} == "-" ]] && echo '1' || echo $2)";
                    eval ${current_command_key}=$current_command_value
                    echo_debug "$1\t=>\t\$$current_command_key = $current_command_value"
                    shift $([[ -z $2 || ${2:0:1} == "-" ]] && echo 0 || echo 1);;
                -*) 
                    current_param_index=0;
                    current_option_key_prefix=$([ $current_command_key ] && echo "${current_command_key}_" || echo "")
                    current_option_key="${current_option_key_prefix}${1:1}"
                    current_option_value=$([[ -z $2 || ${2:0:1} == "-" ]] && echo 1 || echo $2);
                    eval ${current_option_key}=$current_option_value
                    echo_debug "$1\t=>\t\$$current_option_key = $current_option_value"
                    # shift ;;
                    shift $([[ -z $2 || ${2:0:1} == "-" ]] && echo 0 || echo 1);;
                *)
                    current_param_key_prefix=${current_option_key:-$current_command_key}
                    current_param_key_prefix=$([ $current_param_key_prefix ] && echo "${current_param_key_prefix}_" || echo "")
                    current_param_key="${current_param_key_prefix}param${current_param_index}"
                    current_param_value=$1
                    eval ${current_param_key}=$current_param_value
                    let current_param_index=$current_param_index+1
                    echo_debug "$1\t=>\t\$$current_param_key = $current_param_value"
            esac
            shift
        done
    fi

    echo_debug; echo_debug "======================== Parsing params ======================"
    current_param_index=1
    for param in "$@"; do
        echo_debug "\$$current_param_index = $param"
        current_param_index=$[ $current_param_index + 1 ]
    done

    echo_debug; echo_debug "======================== GLOBAL VARIABLES ======================"
    echo_debug "debug = $debug"
    echo_debug "verbose = $verbose"
    echo_debug; echo_debug "=============================================="; echo_debug

    # 使用说明
    if [ -z $help ]; then help; exit 0; fi;

    # 开始处理
    process $@ 
}

main $@


# sh template.sh --command1 -option11 aaa -option12 bbb --command2 -option21 ccc -option22 ddd eee fff ggg
# sh template.sh --command1 -option11 aaa xxx yyy -option12 bbb --command2 -option21 ccc -option22 ddd eee fff ggg
# sh template.sh --command1 -option11 aaa "xxx yyy" -option12 bbb --command2 -option21 ccc -option22 ddd eee fff ggg
# sh template.sh --command1 -option11 aaa xxx yyy -option12 bbb --command2 -option21 ccc -option22 ddd eee fff ggg
# sh template.sh --command1 -option11 aaa -option12 bbb ddd eee fff ggg
# sh template.sh --command1 -option11 -option12 bbb ddd eee fff ggg
# sh template.sh --command1 -option11 -option12 -- bbb ddd eee fff ggg
# sh template.sh --command1 ddd eee fff ggg
# sh template.sh --command1
# sh template.sh ddd eee fff ggg

# sh template.sh aaa bbb --command1 

# sh template.sh -exportArchive xxx -archivePath xcarchivepath -exportPath destinationpath -exportOptionsPlist plistpath
# sh template.sh -exportArchive -archivePath xcarchivepath -exportPath destinationpath -exportOptionsPlist plistpath

# sh template.sh --debug --verbose --build_target WKStudent-QA --build_branch dev1.1.6_build_script --build_app_version 1.1.6 --build_number 100 --build_config Release --env_wkserver https://appwk.baidu.com/ --env_proserver https://appwk.baidu.com/ --env_h5host https://tanbi.baidu.com/ --env_debugtool OFF --env_passport ONLINE --pod_update false --build_path false
# sh template.sh --build_target WKStudent-QA --build_branch dev1.1.6_build_script --build_app_version 1.1.6 --build_number 100 --build_config Release --env_wkserver https://appwk.baidu.com/ --env_proserver https://appwk.baidu.com/ --env_h5host https://tanbi.baidu.com/ --env_debugtool OFF --env_passport ONLINE --pod_update false --build_path false

# sh template.sh --build_target WKStudent-QA --build_branch dev1.1.6_build_script --build_app_version 1.1.6 --build_number 100 --build_config Release --env_wkserver https://appwk.baidu.com/ --env_proserver https://appwk.baidu.com/ --env_h5host https://tanbi.baidu.com/ --env_debugtool OFF --env_passport ONLINE --pod_update false --build_path false

# [build_target] [build_branch] [build_app_version] [build_number] [build_config] [env_wkserver] [env_proserver] [env_h5host] [env_debugtool] [env_passport] [rmdir] [pod_update] [build_path]"