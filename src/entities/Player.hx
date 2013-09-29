package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Player extends Entity {
    public function new (x:Float, y:Float) {
        super(x, y);

        sprite = new Spritemap("graphics/player.png", 16, 16);
        sprite.add("idle", [0]);
        sprite.add("walk", [1,2,3,2], 12);
        sprite.play("idle");

        graphic = sprite;

        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);

        velocity = 0;
    }

    private function handleInput() {
        acceleration = 0;
        if (Input.check("left")) {
            acceleration = -0.5;
        }
        if (Input.check("right")) {
            acceleration = 0.5;
        }
    }

    private function move() {
        velocity += acceleration;
        if (Math.abs(velocity) > 5) {
            velocity = 5 * HXP.sign(velocity);
        }

        if (Math.abs(velocity) < 0.1) { //stop sliding
            velocity = 0;
        }

        if (acceleration == 0) { //friction
            velocity = velocity * 0.9;
        }


        moveBy(velocity, 0);
    }

    private function setAnimations() {
        if (velocity == 0) {
            sprite.play("idle");
        }
        else {
            sprite.play("walk");
        }

        if (velocity < 0) {
            sprite.flipped = true;
        }
        else {
            sprite.flipped = false;
        }
    }

    public override function update() {
        handleInput();
        move();
        setAnimations();
        super.update();
    }

    private var acceleration:Float;
    private var velocity:Float;
    private var sprite:Spritemap;
}
