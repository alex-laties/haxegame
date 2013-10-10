package event;

class EventManager {
    private static var mapper : Map<String, List<Void->Void>>;
    private static var events : List<String>;
    static function __init__() {
        mapper = new Map<String, List<Void->Void>>();
        events = new List<String>();
    }

    public static function onEvent(eventName:String, func:Void->Void) {
        if (mapper.exists(eventName)) {
            mapper.get(eventName).add(func);
        }
        else {
            var list = new List<Void->Void>();
            list.add(func);
            mapper.set(eventName, list);
        }
    }

    public static function pushEvent(eventName:String) {
        events.add(eventName);
    }

    public static function update() {
        Lambda.iter(events, function (evName) {
            if (mapper.exists(evName)) {
                Lambda.iter(mapper.get(evName), function (toCall) {
                    toCall();
                });
            }
        });

        clearEvents();
    }

    public static function clearEvents() {
        events.clear();
    }

    public static function reset() {
        clearEvents();
        mapper = new Map<String, List<Void->Void>>();
    }
}
