#!/usr/bin/env bash

mapfile -t files < <(grep '#!.*env.*bash' -R -l ./*)
shfmt -i 4 -d -ln bash "${files[@]}"
shellcheck --norc -s bash "${files[@]}"
