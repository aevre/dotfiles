export PROXY_HOST="127.0.0.1"
export PROXY_HTTP_PORT=10808
export PROXY_SOCKS_PORT=10809

proxy() {
  local http_proxy_addr="http://${PROXY_HOST}:${PROXY_HTTP_PORT}"
  local socks_proxy_addr="socks5h://${PROXY_HOST}:${PROXY_SOCKS_PORT}"

  case "${1:-}" in
  on | o)
    export HTTP_PROXY="$http_proxy_addr"
    export HTTPS_PROXY="$http_proxy_addr"
    export http_proxy="$http_proxy_addr"
    export https_proxy="$http_proxy_addr"
    export ALL_PROXY="$socks_proxy_addr"
    export all_proxy="$socks_proxy_addr"
    proxy status
    proxy test
    ;;

  off | x)
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
    unset http_proxy https_proxy all_proxy
    printf '代理已关闭\n'
    ;;

  status | s)
    if [[ -n ${HTTP_PROXY:-} && -n ${HTTPS_PROXY:-} && -n ${ALL_PROXY:-} ]]; then
      printf '状态：已开启\nHTTP_PROXY  = %s\nHTTPS_PROXY = %s\nALL_PROXY   = %s\n' \
        "$HTTP_PROXY" "$HTTPS_PROXY" "$ALL_PROXY"
    elif [[ -n ${HTTP_PROXY:-} || -n ${HTTPS_PROXY:-} || -n ${ALL_PROXY:-} ]]; then
      printf '状态：配置不完整\nHTTP_PROXY  = %s\nHTTPS_PROXY = %s\nALL_PROXY   = %s\n' \
        "${HTTP_PROXY:-未设置}" "${HTTPS_PROXY:-未设置}" "${ALL_PROXY:-未设置}"
    else
      printf '状态：已关闭\n'
    fi
    ;;

  test | t)
    if ! command -v curl >/dev/null 2>&1; then
      printf 'proxy: curl 未安装\n' >&2
      return 127
    fi

    printf '测试 HTTP 代理连接...\n'
    if curl --head --silent --show-error --fail \
      --proxy "$http_proxy_addr" --connect-timeout 3 --max-time 8 \
      https://www.google.com >/dev/null; then
      printf '代理连接正常\n'
    else
      printf '代理测试失败，请检查代理客户端、端口或网络连接\n' >&2
      return 1
    fi
    ;;

  *)
    cat <<'EOF'
用法:
  proxy on|o       开启代理
  proxy off|x      关闭代理
  proxy status|s   查看状态
  proxy test|t     测试 HTTP 代理连接
EOF
    return 2
    ;;
  esac
}
