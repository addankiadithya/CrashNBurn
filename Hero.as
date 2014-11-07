dynamic class Hero extends MovieClip {
	function onLoad() {
		velX = 10;
		velY = 10;
		_x = 160;
		_y = 580;
	}
	function onEnterFrame() {
		// CONTROLS //////////movement
		if (Key.isDown(Key.LEFT)) {
			this.snd.start(0,1);
			if (touched() && _rotation == -90) {
				mc = touched();

			} else {
				_rotation = -90;
				_x -= 10;
			}
		} else if (Key.isDown(Key.RIGHT)) {
			this.snd.start(0,1);
			if (touched() && _rotation == 90) {
				mc = touched();
			} else {
				_rotation = 90;
				_x += 10;
			}
		} else if (Key.isDown(Key.UP)) {
			this.snd.start(0,1);
			if (touched() && _rotation == 0) {
				mc = touched();
			} else {
				_rotation = 0;
				_y -= 10;
			}
		} else if (Key.isDown(Key.DOWN)) {
			this.snd.start(0,1);
			if (touched() && _rotation == 180) {
				mc = touched();
			} else {
				_rotation = 180;
				_y += 10;
			}
		}
		touched();
		touchedenhe();
		checkBounds();//checks weather it is in screen or not
		touched();
	}
	function touched():Boolean {
		for (var i in _root.castle) {
			if (_root.B.hitTest(_root.castle[i])) {
				_root.castle[i]._visible = false;
				_root.castle[i]._x = 1000;
				_root.castle[i]._y = 1000;
				_root.B.status = "passive";
				B.x = _x;
				B.y = _y;
				B._visible = false;
			}
			if (player.hitTest(_root.castle[i])) {
				return (true);
			}
		}
	}
	function checkBounds() {
		if (_x>=Stage.width-20-80) {
			_x = Stage.width-20-80;
		}
		if (_x<=20) {
			_x = 20;
		}
		if (_y>=Stage.height-20) {
			_y = Stage.height-20;
		}
		if (_y<=20) {
			_y = 20;
		}
	}
}