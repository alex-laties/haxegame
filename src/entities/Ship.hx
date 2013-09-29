package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Ship extends Entity {
    public function new(x:Float, y:Float) {
        super(x, y);

        graphic = Image.createRect(32, 32, 0xDDEEFF);
        setHitbox(32, 32);

        Input.define("up", [Key.UP, Key.W]);
        Input.define("down", [Key.DOWN, Key.S]);
        Input.define("shoot", [Key.SPACE]);

        velocity = 0;
        type = "player";
    }

    private function handleInput() {
        acceleration = 0;
        if (Input.check("up")) {
            acceleration = -1;
        }
        if (Input.check("down")) {
            acceleration = 1;
        }

        if (Input.pressed("shoot")) {
            scene.add(new Bullet(x+16, y+4));
        }
    }

    private function move() {
        velocity += acceleration * speed;
        if (Math.abs(velocity) > maxVelocity) {
            velocity = maxVelocity * HXP.sign(velocity);
        }
        if (velocity < 0) {
            velocity = Math.min(velocity + drag, 0);
        }
        else if (velocity > 0) {
            velocity = Math.max(velocity - drag, 0);
        }
    }

    public override function update() {
        handleInput();
        move();
        moveBy(0, velocity);
        super.update();
    }

    private var velocity:Float;
    private var acceleration:Float;
    private static inline var maxVelocity:Float = 8;
    private static inline var speed:Float = 3;
    private static inline var drag:Float = 0.4;
}
        
