import arrays

pub struct Varu8s {
pub:
	b []u8 [required]
}

pub fn Varu8s.parse(b []u8) !Varu8s {
	if b.len == 0 {
		return error('cannot parse varu8s from empty bytes')
	}
	len := b[0]
	if len == 0 {
		return Varu8s{
			b: []
		}
	}
	if len > b.len - 1 {
		return error('expected ${len + 1} bytes but got ${b.len} bytes')
	}
	return Varu8s{
		b: b[1..len + 1]
	}
}

pub fn (v Varu8s) encode() []u8 {
	return arrays.append([u8(v.b.len)], v.b)
}

fn (a Varu8s) == (b Varu8s) bool {
	return a.b == b.b
}
