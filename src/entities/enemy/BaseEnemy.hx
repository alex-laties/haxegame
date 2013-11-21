package entities.enemy;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import event.EventManager;

class BaseEnemy extends Entity {
    public function new(x:Float, y:Float) {
        super(x, y);
        type = "enemy";
    }

    public override function moveCollideX(e:Entity) {
        scene.remove(e);
        scene.remove(this);
        if (e.type == "player") {
            EventManager.pushEvent("playerHit");
        }
        return true;
    }

    public function isOffScreen() {
        if (x < 0 || x > HXP.width || y < 0 || y > HXP.height) {
           return true;
        }
        return false; 
    }
}
