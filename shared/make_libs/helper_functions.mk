
# expects 2 arguments
# 1 = input string
# 2 = prefix to check
#
# Algorithm:
# if ($2 == first X chars of $1 -- where X is $2.length (geting first X chars outline below)
# substring($1, 1, $2.length)
# then
# 	true
# else
# 	false
define string_begins_with
$(if $(call seq,$(2),$(call substr,$(1),1,$(call strlen,$(2)))),$(true),$(false))
endef

# expects 2 arguments
# 1 = input string
# 2 = suffix to check
#
# Algorithm:
# if ($2 == last X chars of $1 -- where x is $2.length (getting last X chars outlined below)
# substring($1,
#		if($2.length >= $1.length)
#		then:
# 		1
#		else:
#			($1.length-$2.length)+1
# $1.length -- 2nd parameter to substring
# )
# then:
# 	true
#	else:
# 	false
define string_ends_with
$(if $(call seq,$(2),$(call substr,$(1),$(if $(call gte,$(call strlen,$(2)),$(call strlen,$(1))),1,$(call plus,$(call subtract,$(call strlen,$(1)),$(call strlen,$(2))),1)),$(call strlen,$(1)))),$(true),$(false))
endef

# expects 2 arguments
# 1 = input string
# 2 = prefix to remove (if string begins with it)
#
# Algorithm:
# if the prefix exists at the beginning of the input
# then: substring out the prefix
# 	substring($1, $2.length+1, $1.length)
# else:
# 	return the original input
define remove_prefix
$(if $(call string_begins_with,$(1),$(2)),$(call substr,$(1),$(call plus,$(call strlen,$(2)),1),$(call strlen,$(1))),$(1))
endef


# expects 2 arguments
# 1 = input string
# 2 = suffix to remove (if string begins with it)
#
# Algorithm:
# if the suffix exists at the end of the input
# then:
# substring out the suffix (below)
# 	substring($1, 1,
# 		if($2.length>$2.length) -- notice it is NOT >=
#			then:
# 			$1.length
#			else:
#				$1.length-#2.length
# 	)
# else: return the original input
define remove_suffix
$(if $(call string_ends_with,$(1),$(2)),$(call substr,$(1),1,$(if $(call gt,$(call strlen,$(2)),$(call strlen,$(1))),$(call strlen,$(1)),$(call subtract,$(call strlen,$(1)),$(call strlen,$(2))))),$(1))
endef
