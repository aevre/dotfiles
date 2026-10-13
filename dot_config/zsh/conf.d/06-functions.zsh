# =========================
# Proxy
# =========================
export PROXY_HOST="127.0.0.1"
export PROXY_HTTP_PORT=10808
export PROXY_SOCKS_PORT=10809

proxy() {
  local http_proxy_addr="http://${PROXY_HOST}:${PROXY_HTTP_PORT}"
  local socks_proxy_addr="socks5h://${PROXY_HOST}:${PROXY_SOCKS_PORT}"

  case "${1:-}" in
  on | o)
    # HTTP / HTTPS
    export HTTP_PROXY="$http_proxy_addr"
    export HTTPS_PROXY="$http_proxy_addr"
    export http_proxy="$http_proxy_addr"
    export https_proxy="$http_proxy_addr"

    # SOCKS5
    export ALL_PROXY="$socks_proxy_addr"
    export all_proxy="$socks_proxy_addr"

    proxy status
    proxy test
    ;;

  off | x)
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
    unset http_proxy https_proxy all_proxy

    print -- "代理已关闭"
    ;;

  status | s)
    if [[ -n "$HTTP_PROXY" && -n "$HTTPS_PROXY" && -n "$ALL_PROXY" ]]; then
      print -- "状态：已开启"
      print -- "HTTP_PROXY  = $HTTP_PROXY"
      print -- "HTTPS_PROXY = $HTTPS_PROXY"
      print -- "ALL_PROXY   = $ALL_PROXY"
    elif [[ -n "$HTTP_PROXY" || -n "$HTTPS_PROXY" || -n "$ALL_PROXY" ]]; then
      print -- "状态：配置不完整"
      print -- "HTTP_PROXY  = ${HTTP_PROXY:-未设置}"
      print -- "HTTPS_PROXY = ${HTTPS_PROXY:-未设置}"
      print -- "ALL_PROXY   = ${ALL_PROXY:-未设置}"
    else
      print -- "状态：已关闭"
    fi
    ;;

  test | t)
    if ! (($+commands[curl])); then
      print -u2 -- "proxy: curl 未安装"
      return 127
    fi

    printf '测试 HTTP 代理连接...\n'

    if curl \
      --head \
      --silent \
      --show-error \
      --fail \
      --proxy "$http_proxy_addr" \
      --connect-timeout 3 \
      --max-time 8 \
      https://www.google.com \
      >/dev/null; then
      print -- "代理连接正常"
    else
      print -u2 -- "代理测试失败，请检查代理客户端、端口或网络连接"
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
