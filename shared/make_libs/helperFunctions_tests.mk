# Including parts of GMSL tests, as to have boilerplate to do testing:

ifdef EXPORT_ALL
.EXPORT_ALL_VARIABLES:
endif

include gmsl
include helper_functions.mk

.PHONY: all
all:
	@echo
	@echo Test Summary
	@echo ------------
	@echo "$(call int_decode,$(passed)) tests passed; $(call int_decode,$(failed)) tests failed"

passed :=
failed :=

ECHO := /bin/echo

start_test = $(if $0,$(shell $(ECHO) -n "Testing '$1': " >&2))$(eval current_test := OK)
stop_test  = $(if $0,$(shell $(ECHO) " $(current_test)" >&2))
test_pass = .$(eval passed := $(call int_inc,$(passed)))
test_fail = X$(eval failed := $(call int_inc,$(failed)))$(eval current_test := ERROR '$1' != '$2')
test_assert = $(if $0,$(if $(filter undefined,$(origin 2)),$(eval 2 :=))$(shell $(ECHO) -n $(if $(call seq,$1,$2),$(call test_pass,$1,$2),$(call test_fail,$1,$2)) >&2))

$(call start_test,string_begins_with)
$(call test_assert,$(call string_begins_with,preString,p),$(true))
$(call test_assert,$(call string_begins_with,preString,pr),$(true))
$(call test_assert,$(call string_begins_with,preString,pre),$(true))
$(call test_assert,$(call string_begins_with,preString,preString),$(true))
$(call test_assert,$(call string_begins_with,preString,preStringX),$(false))
$(call test_assert,$(call string_begins_with,preString,preprepre),$(false))
$(call test_assert,$(call string_begins_with,preString,prepreprepre),$(false))
$(call test_assert,$(call string_begins_with,String,pre),$(false))
$(call test_assert,$(call string_begins_with,String,preprepre),$(false))
$(call test_assert,$(call string_begins_with,Stringpre,pre),$(false))
$(call test_assert,$(call string_begins_with,pre,pre),$(true))
$(call test_assert,$(call string_begins_with,s,pre),$(false))
$(call test_assert,$(call string_begins_with,s,p),$(false))
$(call test_assert,$(call string_begins_with,,p),$(false))
$(call test_assert,$(call string_begins_with,s,),$(true))
$(call test_assert,$(call string_begins_with,,),$(true))
$(call stop_test)

$(call start_test,string_ends_with)
$(call test_assert,$(call string_ends_with,preString,p),$(false))
$(call test_assert,$(call string_ends_with,preString,pr),$(false))
$(call test_assert,$(call string_ends_with,preString,pre),$(false))
$(call test_assert,$(call string_ends_with,Stringpre,p),$(false))
$(call test_assert,$(call string_ends_with,Stringpre,pr),$(false))
$(call test_assert,$(call string_ends_with,Stringpre,pre),$(true))
$(call test_assert,$(call string_ends_with,preString,preString),$(true))
$(call test_assert,$(call string_ends_with,preString,preStringX),$(false))
$(call test_assert,$(call string_ends_with,preString,preprepre),$(false))
$(call test_assert,$(call string_ends_with,preString,prepreprepre),$(false))
$(call test_assert,$(call string_ends_with,String,pre),$(false))
$(call test_assert,$(call string_ends_with,String,preprepre),$(false))
$(call test_assert,$(call string_ends_with,Stringpre,pre),$(true))
$(call test_assert,$(call string_ends_with,pre,pre),$(true))
$(call test_assert,$(call string_ends_with,s,pre),$(false))
$(call test_assert,$(call string_ends_with,s,p),$(false))
$(call test_assert,$(call string_ends_with,,p),$(false))
$(call test_assert,$(call string_ends_with,s,),$(true))
$(call test_assert,$(call string_ends_with,,),$(true))
$(call stop_test)

$(call start_test,remove_prefix)
$(call test_assert,$(call remove_prefix,preString,p),reString)
$(call test_assert,$(call remove_prefix,preString,pr),eString)
$(call test_assert,$(call remove_prefix,preString,pre),String)
$(call test_assert,$(call remove_prefix,Stringpre,p),Stringpre)
$(call test_assert,$(call remove_prefix,Stringpre,pr),Stringpre)
$(call test_assert,$(call remove_prefix,Stringpre,pre),Stringpre)
$(call test_assert,$(call remove_prefix,preString,preString),)
$(call test_assert,$(call remove_prefix,preString,preStringX),preString)
$(call test_assert,$(call remove_prefix,preString,preprepre),preString)
$(call test_assert,$(call remove_prefix,preString,prepreprepre),preString)
$(call test_assert,$(call remove_prefix,String,pre),String)
$(call test_assert,$(call remove_prefix,String,preprepre),String)
$(call test_assert,$(call remove_prefix,Stringpre,pre),Stringpre)
$(call test_assert,$(call remove_prefix,pre,pre),)
$(call test_assert,$(call remove_prefix,s,pre),s)
$(call test_assert,$(call remove_prefix,s,p),s)
$(call test_assert,$(call remove_prefix,,p),)
$(call test_assert,$(call remove_prefix,s,),s)
$(call test_assert,$(call remove_prefix,,),)
$(call stop_test)

$(call start_test,remove_suffix)
$(call test_assert,$(call remove_suffix,preString,p),preString)
$(call test_assert,$(call remove_suffix,preString,pr),preString)
$(call test_assert,$(call remove_suffix,preString,pre),preString)
$(call test_assert,$(call remove_suffix,Stringpre,p),Stringpre)
$(call test_assert,$(call remove_suffix,Stringpre,pr),Stringpre)
$(call test_assert,$(call remove_suffix,Stringpre,pre),String)
$(call test_assert,$(call remove_suffix,preString,preString),)
$(call test_assert,$(call remove_suffix,preString,preStringX),preString)
$(call test_assert,$(call remove_suffix,preString,preprepre),preString)
$(call test_assert,$(call remove_suffix,preString,prepreprepre),preString)
$(call test_assert,$(call remove_suffix,String,pre),String)
$(call test_assert,$(call remove_suffix,String,preprepre),String)
$(call test_assert,$(call remove_suffix,Stringpre,pre),String)
$(call test_assert,$(call remove_suffix,pre,pre),)
$(call test_assert,$(call remove_suffix,s,pre),s)
$(call test_assert,$(call remove_suffix,s,p),s)
$(call test_assert,$(call remove_suffix,,p),)
$(call test_assert,$(call remove_suffix,s,),s)
$(call test_assert,$(call remove_suffix,,),)
$(call stop_test)
