dynamic class Enemy extends MovieClip {
	function onLoad() {
		// Setup some properties
		vel_x = 0;
		vel_y = 0;
		_root.enemy._y = 20;
		_root.enemy._x = Math.floor(Math.random()*350)+20;
		_root.enemy.posX = _x;
		_root.enemy.posY = _y;
		bombE = _root.attachMovie("BombEnemy", "bombE", this.getNextHighestDepth());
		bombE.x = 0;
		bombE.y = 0;
		bombE.status = "passive";
		bombE.direction = "up";
	}
	function onUnload() {
		bombE.removeMovieClip();
		_root.Bomb.visible = false;
	}
	function onEnterFrame() {
		_x = Math.ceil(_x+vel_x);
		_y = Math.ceil(_y+vel_y);
		// CONTROLS /////////
		if (Math.sqrt((enemy._x-player._x)*(enemy._x-player._x)+(enemy._y-player._y)*(enemy._y-player._y))<=150) {
			if (_y>_root.player._y) {
				//up
				this.snd.start(0,1);
				_y -= 5;
				_rotation = 180;
			} else if (_x<_root.player._x) {
				//right
				this.snd.start(0,1);
				_x += 5;
				_rotation = -90;
			} else if (_y<_root.player._y) {
				//down
				this.snd.start(0,1);
				_y += 5;
				_rotation = 0;
			} else if (_x>_root.player._x) {
				//left
				this.snd.start(0,1);
				_x -= 5;
				_rotation = 90;
			}
		} 
		else {
			if (_y>_root.symbol._y) {
				//up
				this.snd.start(0,1);
				_y -= 5;
				_rotation = 180;
			} else if (_x<_root.symbol._x) {
				//right
				this.snd.start(0,1);
				_x += 5;
				_rotation = -90;
			} else if (_y<_root.symbol._y) {
				//down
				this.snd.start(0,1);
				_y += 5;
				_rotation = 0;
			} else if (_x>_root.symbol._x) {
				//left
				this.snd.start(0,1);
				_x -= 5;
				_rotation = 90;
			}
		}
		if (_root.bombE.status == "passive") {
			_root.enemy.posX = _x;
			_root.enemy.posY = _y;
			if (Math.sqrt((enemy._x-player._x)*(enemy._x-player._x)+(enemy._y-player._y)*(enemy._y-player._y))<=150) {
				if ((_x>_root.player._x-5 && _x<_root.player._x+5) || (_y>_root.player._y-5 && _y<_root.player._y+5)) {
					_root.bombE._visible = true;
					_root.bombE.status = "fired!";
					if (_y>_root.player._y) {
						//up
						_root.bombE.direction = "up";
					} else if (_x<_root.player._x) {
						//right
						_root.bombE.direction = "right";

					} else if (_y<_root.player._y) {
						//down
						_root.bombE.direction = "down";
					} else if (_x>_root.player._x) {
						//left
						_root.bombE.direction = "left";
					}
				}
			}
			if (Math.sqrt((enemy._x-symbol._x)*(enemy._x-symbol._x)+(enemy._y-symbol._y)*(enemy._y-symbol._y))>50 && Math.sqrt((enemy._x-symbol._x)*(enemy._x-symbol._x)+(enemy._y-symbol._y)*(enemy._y-symbol._y))<200) {
				if ((_x>=_root.symbol._x-10 && _x<=_root.symbol._x+10) || (_y>=_root.symbol._y-10 && _y<=_root.symbol._y+10)) {
					_root.bombE._visible = true;
					_root.bombE.status = "fired!";
					if (_y>_root.symbol._y) {
						//up
						_root.bombE.direction = "up";
					} else if (_x<_root.symbol._x) {
						//right
						_root.bombE.direction = "right";

					} else if (_y<_root.symbol._y) {
						//down
						_root.bombE.direction = "down";
					} else if (_x>_root.symbol._x) {
						//left
						_root.bombE.direction = "left";
					}
				}
				touched();
				destroyede();
				destroyed();
				touchedhe();
			}
		}
		if (bombE.status == "passive") {
			bombE.x = _x;
			bombE.y = _y;
			bombE._visible = false;
		}
		if (bombE.status == "fired!") {
			switch (bombE.direction) {
				case "up" :
					bombE.y -= bombE._height;

					break;
				case "down" :
					bombE.y += bombE._height;

					break;
				case "right" :
					bombE.x += bombE._height;

					break;
				case "left" :
					bombE.x -= bombE._height;

					break;
			}
			if (bombE.y<_root.enemy.posY-100) {
				bombE.status = "passive";
			}
			if (bombE.y>_root.enemy.posY+100) {
				bombE.status = "passive";
			}
			if (bombE.x>_root.enemy.posX+100) {
				bombE.status = "passive";
			}
			if (bombE.x<_root.enemy.posX-100) {
				bombE.status = "passive";
			}
		}
		bombE._x = bombE.x;
		bombE._y = bombE.y;

		if (this.hitTest(_root.bomb)) {
			this.removeMovieClip();
			gotoAndStop("wannaplayagain");
		}
		touched();
		destroyede();
		destroyed();
		touchedhe();
	}
	function checkBounds() {
		if (_x>=Stage.width-20-80) {
			_x = Stage.width-20-80;
		} else if (_x<=20) {
			_x = 20;
		} else if (_y>=Stage.height-20) {
			_y = Stage.height-20;
		} else if (_y<=20) {
			_y = 20;
		}
	}
	function destroyede() {
		if (_root.bombE.hitTest(_root.player)) {
			_root.bombE._visible = false;
			_root.lifehero.gotoAndStop(_root.lifehero._currentframe+1);
			if (_root.lifehero._currentframe>=20) {
				_root.bombE._visible = false;
				_root.player.gotoAndPlay(2);
			}
		}
	}
	function destroyed() {
		if (_root.bombE.hitTest(_root.symbol)) {
			_root.symbol._visible = false;
			_root.bombE.removeMovieClip();
			_root.gotoAndStop(3);
		}
	}
	function touchedhe() {
		if (_root.player.hitTest(_root.enemy)) {
			_root.enemy.removeMovieClip();
			_root.bombE.removeMovieClip();
			_root.player.removeMovieClip();
			_root.B.removeMovieClip();
			_root.gotoAndStop("blasting");
		}
	}
	function touched() {
		for (var i in _root.castle) {
			if (_root.bombE.hitTest(_root.castle[i])) {
				_root.castle[i]._visible = false;
				_root.castle[i]._x = 1000;
				_root.castle[i]._y = 1000;
				bombE.status = "passive";
				bombE.x = _x;
				bombE.y = _y;
				bombE._visible = false;
			}
		}
	}
}