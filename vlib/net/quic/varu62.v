module quic

// variable length unsigned integer encoding from rfc9000 sec.16
// short version -> len in [1,2,4,8] and first two msbs encodes the log2(len) of n
// can represent 0..1<<62
pub struct Varu62 {
pub:
	b []u8 [required]
}

// return as u64
// cache this for immutable instances
pub fn (v Varu62) u64() u64 {
	mut n := u64(v.b[0] & 0b00111111)
	for i in v.b[1..] {
		n = n * 256 + i
	}
	return n
}

// create from u64
pub fn Varu62.u64(n u64) !Varu62 {
	if n >= u64(1) << 62 {
		return error('cannnot encode more than 2^62-1')
	}
	msb := match true {
		n < 64 {
			u8(0b00)
		}
		n < 16384 {
			u8(0b01)
		}
		n < 1073741824 {
			u8(0b10)
		}
		else {
			u8(0b11)
		}
	}
	len := 1 << msb
	mut result := []u8{len: len, cap: len}
	mut tn := n
	for i in 0 .. len {
		result[len - 1 - i] = u8(tn % 256)
		tn /= 256
	}
	result[0] |= msb << 6

	return Varu62{
		b: result
	}
}

// parse one varu62 from byte array
pub fn Varu62.parse(b []u8) !Varu62 {
	if b.len == 0 {
		return error('cannot parse varu62 from empty byte array')
	}
	msb := b[0] >> 6
	len := u8(1 << msb)
	if len > b.len {
		return error('expected ${len} bytes but got ${b.len} bytes')
	}

	return Varu62{
		b: b[..len]
	}
}
