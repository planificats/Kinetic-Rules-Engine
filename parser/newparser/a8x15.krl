{"global":[],"dispatch":[{"domain":"youtube.com"},{"domain":"baconsalt.com"}],"ruleset_name":"a8x15","rules":[{"blocktype":"every","emit":null,"post":{"type":null,"cons":[null]},"pre":[{"rhs":{"source":"page","args":[{"val":"caller","type":"str"}],"predicate":"env","type":"qualified"},"type":"expr","lhs":"url"},{"rhs":{"args":null,"name":null,"obj":{"val":"url","type":"var"},"type":"operator"},"type":"expr","lhs":"url"}],"name":"youtube","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"youtube.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":null}],"meta":{"author":"Sam Curren","description":"\nDisplays a QR code for any site     \n","name":"QRCode","logging":"off"}}
