package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;

import entities.Player;

class GameScene extends Scene {
    public function new() {
        super();
    }

    public override function begin() {
        add(new entities.Ship(16, HXP.halfHeight));
        spawn();
    }

    public override function update() {
        spawnTimer -= HXP.elapsed;
        if (spawnTimer < 0) {
            spawn();
        }
        super.update();
    }

    private function spawn() {
        var y = Math.random() * HXP.height;
        add(new entities.Enemy(HXP.width, y));
        spawnTimer = 1;
    }

    private var spawnTimer:Float;
}
