package geom;

import geom.Vec3;

abstract Vec3(Array<Float>) from Array<Float> to Array<Float>{
	public inline function new(x:Float = 0, y:Float = 0, z:Float = 0) {
		this = [x,y,z];
	}

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;

	public inline function get_x():Float return this[0];
	public inline function get_y():Float return this[1];
	public inline function get_z():Float return this[2];
	public inline function set_x(v:Float):Float return this[0] = v;
	public inline function set_y(v:Float):Float return this[1] = v;
	public inline function set_z(v:Float):Float return this[2] = v;

	@:from inline static public function fromFloat(v:Float) {
		return new Vec3(v,v,v);
	}

	@:from inline static public function fromArray(arr:Array<Null<Float>>) {
		return new Vec3(
			null == arr[0] ? 0:arr[0],
			null == arr[1] ? 0:arr[1],
			null == arr[2] ? 0:arr[2]
		);
	}

	@:from inline static public function fromTypedef(o:{x:Dynamic, y:Dynamic, z:Dynamic}) {
		return new Vec3(o.x, o.y, o.z);
	}

	@:to public inline function toArray():Array<Float>
		return this.copy();


	//------- Class Methods -------//
	public inline function length():Float
		return Math.sqrt(dot(this));

	public inline function lengthSquared():Float
		return dot(this);

	public inline function dot(prod:Vec3):Float
		return x * prod.x + y * prod.y + z * prod.z;

	public inline function normalize():Vec3{
		var d:Float = length();
		this[0] /= d;
		this[1] /= d;
		this[2] /= d;
		return this;
	}

	public inline function zero():Vec3{
		this[0] = 0;
		this[1] = 0;
		this[2] = 0;
		return this;
	}

	public inline function toString() {
	    return "Vec3("+x+","+y+","+z+")";
	}


	//------- Operator Overloads -------//
	//Order of definition is important
	@:op(A += B)
	static public inline function addAssign(a:Vec3, b:Vec3){
		a.x += b.x;
		a.y += b.y;
		a.z += b.z;
		return a;
	}

	@:op(A *= B)
	static public inline function multiplyIntAssign(a:Vec3, multiplier:Int){
		a.x *= multiplier;
		a.y *= multiplier;
		a.z *= multiplier;
		return a;
	}
	@:op(A *= B)
	static public inline function multiplyFloatAssign(a:Vec3, multiplier:Float){
		a.x *= multiplier;
		a.y *= multiplier;
		a.z *= multiplier;
		return a;
	}
	@:op(A *= B)
	static public inline function multiplyVec3Assign(a:Vec3, b:Vec3){
		a.x *= b.x;
		a.y *= b.y;
		a.z *= b.z;
		return a;
	}

	@:op(A + B)
	static public inline function addVec3(a:Vec3, b:Vec3):Vec3
		return new Vec3(a.x + b.x, a.y + b.y, a.z + b.z);

	@:op(A - B)
	static public inline function subtractVec3(a:Vec3, b:Vec3):Vec3
		return new Vec3(a.x - b.x, a.y - b.y, a.z - b.z);

	@:op(A * B)
	static public inline function multiplyInt(a:Vec3, B:Int):Vec3
		return new Vec3(a.x*B, a.y*B, a.z*B);
	@:op(A * B)
	static public inline function multiplyFloat(a:Vec3, B:Float):Vec3
		return new Vec3(a.x*B, a.y*B, a.z*B);
	@:op(A * B)
	static public inline function multiplyVec3(a:Vec3, b:Vec3):Vec3
		return new Vec3(a.x*b.x, a.y*b.y, a.z*b.z);

	@:op(A / B)
	static public inline function divideInt(a:Vec3, B:Int):Vec3
		return new Vec3(a.x/B, a.y/B, a.z/B);
	@:op(A / B)
	static public inline function divideFloat(a:Vec3, B:Float):Vec3
		return new Vec3(a.x/B, a.y/B, a.z/B);
	@:op(A / B)
	static public inline function divideVec3(a:Vec3, b:Vec3):Vec3
		return new Vec3(a.x/b.x, a.y/b.y, a.z/b.z);

	@:op(-A)
	static public inline function invert(a:Vec3):Vec3
		return new Vec3(-a.x, -a.y, -a.z);

	@:op(A == B)
	static public inline function equalsDynamic(a:Vec3, B:Dynamic)
		return false;
	@:op(A == B)
	static public inline function equalsVec3(a:Vec3, b:Vec3)
		return (a.x == b.x) && (a.y == b.y) && (a.z == b.z);

	
	//------- Static Methods -------//
	static public inline function difference(a:Vec3, b:Vec3, R:Vec3):Vec3{//store result in r
		R.x = b.x - a.x;
		R.y = b.y - a.y;
		R.z = b.z - a.z;
		return R;
	}

	static public inline function distance(a:Vec3, b:Vec3):Float{
		return Math.sqrt(distance(a,b));
	}

	static public inline function distanceSquared(a:Vec3, b:Vec3):Float{
		return length3Squared(b.x - a.x, b.y - a.y, b.z - a.z);
	}

	// * private *
	static private inline function length3Squared(x:Float, y:Float, z:Float):Float{
		return x*x + y*y + z*z;
	}
}