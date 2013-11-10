package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Ship extends Entity {
    private var velocity:Float;
    private var _velX:Float;
    private var _velY:Float;
    private var acceleration:Float;
    private var _accelX:Float;
    private var _accelY:Float;
    private static inline var maxVelocity:Float = 8;
    private static inline var speed:Float = 3;
    private static inline var drag:Float = 0.4;

    public function new(x:Float, y:Float) {
        super(x, y);

        graphic = Image.createRect(32, 32, 0xDDEEFF);
        setHitbox(32, 32);

        Input.define("up", [Key.UP, Key.W]);
        Input.define("down", [Key.DOWN, Key.S]);
        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);

        _velX = 0;
        _velY = 0;
        type = "player";
    }

    private inline function handleInput() {
        _accelX = 0;
        _accelY = 0;
        //not chained as if-else to allow multiple key presses
        if (Input.check("up")) {
            _accelY -= 1;
        }
        if (Input.check("down")) {
            _accelY += 1;
        }
        if (Input.check("left")) {
            _accelX -= 1;
        }
        if (Input.check("right")) {
            _accelX += 1;
        }
    }
    
    private inline function normalizeVelocity(vel:Float) {
    /**
      caps velocity and adds drag
    */
        if (Math.abs(vel) > maxVelocity) {
            vel = maxVelocity * HXP.sign(vel);
        }

        if (vel < 0) {
            vel = Math.min(vel + drag, 0);
        }
        else if (vel > 0) {
            vel = Math.max(vel - drag, 0);
        }

        return vel;
    }

    private inline function move() {
        _velX += _accelX * speed;
        _velY += _accelY * speed;
        _velX = normalizeVelocity(_velX);
        _velY = normalizeVelocity(_velY);

        var newX = x + _velX;
        var newY = y + _velY;

        if (newX <= 0) {
            _velX -= newX;
        }
        else if (newX >= (HXP.width - width)) {
            _velX = HXP.width - width - x;
        }

        if (newY <= 0) {
            _velY -= newY;
        }
        else if (newY >= (HXP.height - height)) {
            _velY = HXP.height - height - y;
        }
    }

    public override function update() {
        handleInput();
        move();
        moveBy(_velX, _velY);
        super.update();
    }
}
