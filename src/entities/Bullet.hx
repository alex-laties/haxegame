package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Bullet extends Entity {
    public function new(x:Float, y:Float) {
        super(x, y);
        graphic = Image.createRect(16, 4);
        setHitbox(16, 4);
        type = "bullet";
    }

    public override function moveCollideX(e:Entity) {
        scene.remove(e);
        scene.remove(this);
        return true;
    }

    public override function update() {
        moveBy(20, 0, "enemy");
        super.update();
    }
}
