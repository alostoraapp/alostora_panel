// Source - https://stackoverflow.com/a
// Posted by Damian K. Bast
// Retrieved 2025-11-21, License - CC BY-SA 4.0

#!/usr/bin/expect -f

set timeout -1


spawn sh -i -c {
    flutter run -d web-server --web-port 4000
}

set run_id $spawn_id

expect "For a more detailed help message, press \"h\". To quit, press \"q\"."
spawn sh -c {
    adb reverse tcp:4000 tcp:4000
    adb shell am start -a android.intent.action.VIEW -d http://localhost:4000
}

interact -i $run_id
