// composite events
ruleset 1 {
    rule test0 is active {
        select when mail from #(.*)@windley.com# setting (userid)
	noop();
    }
}