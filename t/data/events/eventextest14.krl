// composite events
ruleset 1 {
    rule test0 is active {
	select when pageview url #bar.html# or pageview url #foo.html#
	{
		noop();
	}
    }
}
