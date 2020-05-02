# This file is part of The Open GApps script of @mfonville.
#
#    The Open GApps scripts are free software: you can redistribute it
#    and/or modify it under the terms of the GNU General Public
#    License as published by the Free Software Foundation, either
#    version 3 of the License, or (at your option) any later version.
#
#    These scripts are distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    General Public License for more details.
#

# Reads stdin and for each variable name argument VAR replaces @VAR@
# with the value of $VAR and prints the result to stdout.
substitute_vars() {
  subst_vars_sed=''
  for subst_var in "$@"; do
    eval "subst_val=\$$subst_var"
    # Escape characters that are special in the sed "s" function's
    # replacement text (ampersand, backslash, and newline). The string
    # "EOV" is appended to the value and then removed so that trailing
    # newlines in the variable's value are preserved.
    subst_val_esc=$(printf %sEOV\\n "$subst_val" | sed -e 's/[&\]/\\&/g;s/.*/&\\/')
    subst_val_esc=${subst_val_esc%EOV*}
    subst_vars_sed=$subst_vars_sed"
s&@$subst_var@&$subst_val_esc&g"
  done
  sed -e "$subst_vars_sed"
}
