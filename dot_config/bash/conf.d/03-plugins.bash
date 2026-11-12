# Flyline replaces Readline when its Bash loadable is installed.
if enable flyline 2>/dev/null || enable -f /usr/lib/bash/libflyline.so flyline 2>/dev/null; then
  flyline set-cursor --backend terminal
else
  printf 'bash: optional plugin not found: flyline\n' >&2
fi
