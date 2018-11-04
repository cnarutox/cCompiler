#############################################################################
#                     U N R E G I S T E R E D   C O P Y
# 
# You are on day 25 of your 30 day trial period.
# 
# This file was produced by an UNREGISTERED COPY of Parser Generator. It is
# for evaluation purposes only. If you continue to use Parser Generator 30
# days after installation then you are required to purchase a license. For
# more information see the online help or go to the Bumble-Bee Software
# homepage at:
# 
# http://www.bumblebeesoftware.com
# 
# This notice must remain present in the file. It cannot be removed.
#############################################################################

#############################################################################
# myparser.v
# YACC verbose file generated from myparser.y.
# 
# Date: 11/04/18
# Time: 10:48:25
# 
# AYACC Version: 2.07
#############################################################################


##############################################################################
# Rules
##############################################################################

    0  $accept : sectence $end

    1  sectence : obj

    2  obj : object


##############################################################################
# States
##############################################################################

state 0
	$accept : . sectence $end

	object  shift 1

	obj  goto 2
	sectence  goto 3


state 1
	obj : object .  (2)

	.  reduce 2


state 2
	sectence : obj .  (1)

	.  reduce 1


state 3
	$accept : sectence . $end  (0)

	$end  accept


##############################################################################
# Summary
##############################################################################

3 token(s), 3 nonterminal(s)
3 grammar rule(s), 4 state(s)


##############################################################################
# End of File
##############################################################################
