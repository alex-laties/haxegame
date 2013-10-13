package entities.enemy;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

import event.EventManager;

class Enemy extends BaseEnemy {
    public function new(x:Float, y:Float) {
        super(x, y);
        graphic = Image.createRect(32, 32);
        setHitbox(32, 32);
    }

    public override function moveCollideX(e:Entity) {
        scene.remove(e);
        scene.remove(this);
        if (e.type == "player") {
            EventManager.pushEvent("playerHit");
        }
        return true;
    }

    public override function update() {
        moveBy(-5, 0, "player");
        if (x < 0 || x > HXP.width) {
            scene.remove(this);
            EventManager.pushEvent("enemyRemoved");
        }
        super.update();
    }
}
