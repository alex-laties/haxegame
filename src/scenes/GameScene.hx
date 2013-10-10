package scenes;

import com.haxepunk.HXP;
import com.haxepunk.Scene;

import entities.Player;
import entities.TimerText;
import entities.ScoreText;

import event.EventManager;

class GameScene extends Scene {
    private var score:ScoreText;
    private var spawnTimer:Float;
    public var gameOver:Bool;

    public function new() {
        super();
    }

    public override function begin() {
        gameOver = false;
        add(new entities.Ship(16, HXP.halfHeight));
        add(new TimerText("Start", 0, 0));
        score = new ScoreText(HXP.halfWidth, 0);
        add(score);

        spawn();
    }

    public function reset() {
        removeAll();
        EventManager.reset();
        begin();
    }

    public override function update() {
        EventManager.update();
        if (gameOver) {
            reset();
        }
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
}
