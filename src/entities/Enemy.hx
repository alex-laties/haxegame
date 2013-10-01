package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

import scenes.GameScene;

class Enemy extends Entity {
    public function new(x:Float, y:Float) {
        super(x, y);
        graphic = Image.createRect(32, 32);
        setHitbox(32, 32);
        type = "enemy";
    }

    public override function moveCollideX(e:Entity) {
        scene.remove(e);
        scene.remove(this);
        if (e.type == "player") {
            cast(scene, GameScene).gameOver = true;
        }
            
        return true;
    }

    public override function update() {
        moveBy(-5, 0, "player");
        super.update();
    }
}
