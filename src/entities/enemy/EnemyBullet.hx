package entities.enemy;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import scenes.GameScene;
import event.EventManager;

class EnemyBullet extends Entity {
    private static var speed : Float = 6;
    private var _tarX : Float;
    private var _tarY : Float;

    private var _vecX : Float;
    private var _vecY : Float;

    public function new(x:Float, y:Float, tarX:Float, tarY:Float) {
        super(x, y);
        graphic = Image.createRect(4, 4, 0.3);
        setHitbox(4, 4);
        type = "enemy";

        _tarX = tarX;
        _tarY = tarY;

        var diffX = _tarX - x;
        var diffY = _tarY - y;

        var vec = Math.sqrt(Math.pow(diffX, 2) + Math.pow(diffY, 2));

        _vecX = diffX / vec;
        _vecY = diffY / vec;
    }

    public override function moveCollideX(e:Entity) {
        scene.remove(e);
        scene.remove(this);

        if (e.type == "player") {
            EventManager.pushEvent("playerHit");
        }
        return true;
    }

    public override function moveCollideY(e:Entity) {
        scene.remove(e);
        scene.remove(this);

        if (e.type == "player") {
            EventManager.pushEvent("playerHit");
        }
        return true;
    }

    public function outOfBounds() {
        if (x <= 0 || x >= HXP.width || y <= 0 || y >= HXP.height) {
            return true;
        }
        return false;
    }

    public override function update() {
        moveBy(_vecX*speed, _vecY*speed, "player");

        if (outOfBounds()){
            scene.remove(this);
        }
        super.update();
    }
}
