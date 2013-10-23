package entities.enemy;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import scenes.GameScene;
import event.EventManager;

class EnemyBullet extends Entity {
    private var _tarX : Float;
    private var _tarY : Float;

    public function new(x:Float, y:Float, tarX:Float, tarY:Float) {
        super(x, y);
        graphic = Image.createRect(4, 4, 0.3);
        setHitbox(4, 4);
        type = "enemy";

        _tarX = tarX;
        _tarY = tarY;
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

    public override function update() {
        moveTowards(_tarX, _tarY, 6, "player");

        if (x <= _tarX && y <= _tarY){
            scene.remove(this);
        }
        super.update();
    }
}
