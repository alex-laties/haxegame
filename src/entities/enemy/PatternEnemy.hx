package entities.enemy;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

import event.EventManager;
import scenes.GameScene;

typedef Vector2 = {
    var x : Float;
    var y: Float;
}

class PatternEnemy extends BaseEnemy {
    private var goingLeft : Bool;

    public function new(x:Float, y:Float) {
        super(x, y);
        graphic = Image.createRect(16, 32);
        setHitbox(16, 32);
        goingLeft = true;
    }

    public function nextPosition() {
        var distY = 0.0;
        var distX = 0.0;

        distX = Math.abs(x - HXP.width / 2) / 8;
        if (goingLeft && x < (HXP.width/2 + 10)) {
            goingLeft = false;
            fireAtPlayer();
        }

        if (goingLeft) {
            distX = -distX;
        }
        var dist : Vector2 = { x: distX, y: distY};
        return dist;
    }

    public function fireAtPlayer() {
        var player = cast(scene, GameScene).getPlayer();
        scene.add(new EnemyBullet(x-16, y-4, player.x, player.y)); 
    }

    public override function update() {
        var move = nextPosition();
        moveBy(move.x, move.y);
        if (x < 0 || x > HXP.width) {
            scene.remove(this);
            EventManager.pushEvent("enemyRemoved");
        }

        super.update();
    }
}
