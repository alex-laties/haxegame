package scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;

import entities.enemy.EnemySpawner;
import entities.Player;
import entities.TimerText;
import entities.ScoreText;

import event.EventManager;

class GameScene extends Scene {
    private var player:Entity;
    private var score:ScoreText;
    private var spawnTimer:Float;
    private var spawner:EnemySpawner;
    public var gameOver:Bool;

    public function new() {
        super();
    }

    public override function begin() {
        gameOver = false;
        player = new entities.Ship(16, HXP.halfHeight);
        add(player);
        add(new TimerText("Start", 0, 0));
        score = new ScoreText(HXP.halfWidth, 0);
        add(score);

        spawner = new EnemySpawner();

        EventManager.onEvent("playerHit", function() {
            gameOver = true;
        });

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

        if (spawner.timeToSpawn()) {
            add(spawner.spawn());
        }
        super.update();
    }

    private function spawn() {
        var y = Math.random() * HXP.height;
        add(new entities.enemy.Enemy(HXP.width, y));
        spawnTimer = 1;
    }

    public function getPlayer() {
        return player;
    }
}
